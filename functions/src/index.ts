import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();

export const onVideoCreated = functions.firestore
  .document('videos/{videoId}')
  .onCreate(async (snapshot, context) => {
    const spawn = require('child-process-promise').spawn;
    const video = snapshot.data();
    await spawn('ffmpeg', [
      '-i', // file input
      video.fileUrl,
      '-ss', // 비디오 시간 이동
      '00:00:00',
      '-vframes', // get frames
      '1', // take first frame
      `/tmp/${snapshot.id}.jpg`, // save temporary -> functions 실행 이후 삭제됨
    ]);

    const storage = admin.storage();
    const [file] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
      destination: `thumbnails/${snapshot.id}.jpg`,
    });

    await file.makePublic();
    await snapshot.ref.update({ thumbnailUrl: file.publicUrl() });

    const db = admin.firestore();
    await db
      .collection('users')
      .doc(video.creatorUid)
      .collection('videos')
      .doc(snapshot.id)
      .set({
        thumbnailUrl: file.publicUrl(),
        videoId: snapshot.id,
      });
  });

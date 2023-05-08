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
const region = functions.region('asia-northeast3');
const db = admin.firestore();
const storage = admin.storage();
const storageUrl = 'https://storage.googleapis.com/tiktok-jw.appspot.com/';

export const onVideoCreated = region.firestore
  .document('videos/{videoId}')
  .onCreate(async (snapshot, context) => {
    const spawn = require('child-process-promise').spawn;
    const video = snapshot.data();
    const videoPath = `videos/${video.creatorUid}/${
      video.fileUrl.split('%2F')[2].split('?')[0]
    }`;

    await storage.bucket().file(videoPath).download({
      destination: '/tmp/video.mp4',
      decompress: false,
    });

    await spawn('ffmpeg', [
      '-i', // file input
      '/tmp/video.mp4',
      '-ss', // 비디오 시간 이동
      '00:00:00',
      '-vframes', // get frames
      '1', // take first frame
      //   'vf',
      //   'scale=150:-1', // width: 150, height: 영상 비율에 맞게
      `/tmp/${snapshot.id}.jpg`, // save temporary -> functions 실행 이후 삭제됨
    ]);

    const [file] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
      destination: `thumbnails/${snapshot.id}.jpg`,
    });

    await file.makePublic();
    await snapshot.ref.update({ thumbnailUrl: file.publicUrl() });

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

export const onVideoLiked = region.firestore
  .document('likes/{likeId}')
  .onCreate(async (snapshot, context) => {
    const [videoId, uid] = snapshot.id.split('<>');
    const thumbnailUrl = `${storageUrl}thumbnails%2F${videoId}.jpg`;

    await db
      .collection('videos')
      .doc(videoId)
      .update({ likes: admin.firestore.FieldValue.increment(1) });

    await db
      .collection('users')
      .doc(uid)
      .collection('liked')
      .doc(videoId)
      .set({ thumbnailUrl, videoId });
  });

export const onVideoCancelLiked = region.firestore
  .document('likes/{likeId}')
  .onDelete(async (snapshot, context) => {
    const [videoId, uid] = snapshot.id.split('<>');

    await db
      .collection('videos')
      .doc(videoId)
      .update({ likes: admin.firestore.FieldValue.increment(-1) });

    await db
      .collection('users')
      .doc(uid)
      .collection('liked')
      .doc(videoId)
      .delete();
  });

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/videos/models/video_model.dart';

class VideosRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // upload a video file
  UploadTask uploadVideoFile(File video, String uid) {
    final fileRef = _storage.ref().child(
          '/videos/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}',
        );
    return fileRef.putFile(video);
  }

  // create a video document
  Future<void> saveVideo(VideoModel video) async {
    await _firestore.collection('videos').add(video.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos(
      {int? lastItemCreatedAt}) async {
    final query = _firestore
        .collection('videos')
        .orderBy('createdAt', descending: true)
        .limit(2);

    if (lastItemCreatedAt == null) {
      return await query.get();
    } else {
      return await query.startAfter([lastItemCreatedAt]).get();
    }
  }

  Future<void> likeVideo({
    required String videoId,
    required String uid,
  }) async {
    final query = _firestore.collection('likes').doc('$videoId<>$uid');
    final like = await query.get();

    if (!like.exists) {
      await query.set({'createdAt': DateTime.now().millisecondsSinceEpoch});
    } else {
      await query.delete();
    }
  }
}

final videosRepository = Provider(
  (ref) => VideosRepository(),
);

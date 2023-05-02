import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_flutter/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_flutter/features/users/view_models/user_vm.dart';
import 'package:tiktok_flutter/features/videos/models/video_model.dart';
import 'package:tiktok_flutter/features/videos/repositories/videos_repository.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videosRepository);
  }

  Future<void> uploadVideo(File video, BuildContext context) async {
    final user = ref.read(authenticationRepository).user;
    final userProfile = ref.read(userProvider).value;
    if (userProfile == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final task = await _repository.uploadVideoFile(
        video,
        user!.uid,
      );
      if (task.metadata != null) {
        await _repository.saveVideo(
          VideoModel(
            title: 'from flutter',
            description: 'code challenge',
            fileUrl: await task.ref.getDownloadURL(),
            thumbnailUrl: '',
            creatorUid: user.uid,
            creator: userProfile.name,
            likes: 0,
            comments: 0,
            createdAt: DateTime.now().millisecondsSinceEpoch,
          ),
        );
        context.go('/home');
      }
    });
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);

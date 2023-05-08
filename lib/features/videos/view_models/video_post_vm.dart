import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_flutter/features/videos/repositories/videos_repository.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideosRepository _videosRepository;
  late final _videoId;

  @override
  FutureOr<void> build(String videoId) {
    _videoId = videoId;
    _videosRepository = ref.read(videosRepository);
  }

  Future<void> likeVideo() async {
    final user = ref.read(authenticationRepository).user;
    await _videosRepository.likeVideo(videoId: _videoId, uid: user!.uid);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);

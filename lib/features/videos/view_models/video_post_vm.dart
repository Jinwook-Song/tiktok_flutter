import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_flutter/features/videos/repositories/videos_repository.dart';
import 'package:tiktok_flutter/features/videos/view_models/video_timeline_vm.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<bool, String> {
  late final VideosRepository _videosRepository;
  // ignore: prefer_typing_uninitialized_variables
  late final _videoId;
  late bool _isLiked;

  @override
  FutureOr<bool> build(String arg) async {
    final user = ref.read(authenticationRepository).user;
    _videoId = arg;
    _videosRepository = ref.read(videosRepository);
    _isLiked = await _videosRepository.isLiked(
      videoId: _videoId,
      uid: user!.uid,
    );
    return _isLiked;
  }

  Future<void> toggleVideoLike() async {
    final user = ref.read(authenticationRepository).user;
    _isLiked = !_isLiked;
    state = AsyncData(_isLiked);
    if (_isLiked) {
      ref.read(videoTimelineProvider.notifier).increaseLike(_videoId);
    } else {
      ref.read(videoTimelineProvider.notifier).decreaseLike(_videoId);
    }
    await _videosRepository.toggleVideoLike(
      videoId: _videoId,
      uid: user!.uid,
    );
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, bool, String>(
  () => VideoPostViewModel(),
);

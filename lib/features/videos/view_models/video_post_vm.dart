import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_flutter/features/videos/repositories/videos_repository.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<bool, String> {
  late final VideosRepository _videosRepository;
  // ignore: prefer_typing_uninitialized_variables
  late final _videoId;

  @override
  FutureOr<bool> build(String arg) async {
    final user = ref.read(authenticationRepository).user;
    _videoId = arg;
    _videosRepository = ref.read(videosRepository);
    return await _videosRepository.isLiked(videoId: _videoId, uid: user!.uid);
  }

  Future<void> toggleVideoLike() async {
    final user = ref.read(authenticationRepository).user;
    final isLiked = await _videosRepository.toggleVideoLike(
      videoId: _videoId,
      uid: user!.uid,
    );
    state = AsyncData(isLiked);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, bool, String>(
  () => VideoPostViewModel(),
);

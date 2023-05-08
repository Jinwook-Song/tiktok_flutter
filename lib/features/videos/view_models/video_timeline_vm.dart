import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/videos/models/video_model.dart';
import 'package:tiktok_flutter/features/videos/repositories/videos_repository.dart';

class VideoTimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _videosRepository;
  List<VideoModel> _videoList = [];

  Future<List<VideoModel>> _fetchVideos({int? lastItemCreatedAt}) async {
    final result = await _videosRepository.fetchVideos(
        lastItemCreatedAt: lastItemCreatedAt);
    final videos = result.docs
        .map((doc) => VideoModel.fromJson(
              json: doc.data(),
              videoId: doc.id,
            ))
        .toList();
    return videos;
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    _videosRepository = ref.read(videosRepository);
    _videoList = await _fetchVideos(lastItemCreatedAt: null);
    return _videoList;
  }

  Future<void> fetchNextPage() async {
    final nextVideos = await _fetchVideos(
      lastItemCreatedAt: _videoList.last.createdAt,
    );
    _videoList = [..._videoList, ...nextVideos];
    state = AsyncValue.data(_videoList);
  }

  Future<void> refresh() async {
    final videos = await _fetchVideos(lastItemCreatedAt: null);
    _videoList = videos;
    state = AsyncValue.data(videos);
  }

  void increaseLike(String videoId) {
    final targetVideo = state.value!.firstWhere((video) => video.id == videoId);
    final targetIndex = state.value!.indexWhere((video) => video.id == videoId);
    final updated = targetVideo.copyWith(likes: targetVideo.likes + 1);
    final copy = [...state.value!];
    copy.removeWhere((video) => video.id == videoId);
    copy.insert(targetIndex, updated);
    _videoList = [...copy];
    state = AsyncValue.data(_videoList);
  }

  void decreaseLike(String videoId) {
    final targetVideo = state.value!.firstWhere((video) => video.id == videoId);
    final targetIndex = state.value!.indexWhere((video) => video.id == videoId);
    final updated = targetVideo.copyWith(likes: targetVideo.likes - 1);
    final copy = [...state.value!];
    copy.removeWhere((video) => video.id == videoId);
    copy.insert(targetIndex, updated);
    _videoList = [...copy];
    state = AsyncValue.data(_videoList);
  }
}

final videoTimelineProvider =
    AsyncNotifierProvider<VideoTimelineViewModel, List<VideoModel>>(
  () => VideoTimelineViewModel(),
);

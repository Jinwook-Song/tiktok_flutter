import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/videos/models/video_model.dart';

class VideoTimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _videoList = [VideoModel(title: 'First video')];

  void uploadVideo() async {
    state = const AsyncValue.loading(); // trigger loading
    await Future.delayed(const Duration(seconds: 2));

    final newVideo = VideoModel(title: '${DateTime.now()}}');
    _videoList = [..._videoList, newVideo];
    state = AsyncValue.data(_videoList);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    // fake api call
    await Future.delayed(const Duration(seconds: 3));

    // throw Exception('❌ Fetch failed');
    return _videoList;
  }
}

final videoTimelineProvider =
    AsyncNotifierProvider<VideoTimelineViewModel, List<VideoModel>>(
  () => VideoTimelineViewModel(),
);

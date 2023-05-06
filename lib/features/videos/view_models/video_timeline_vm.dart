import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/videos/models/video_model.dart';
import 'package:tiktok_flutter/features/videos/repositories/videos_repository.dart';

class VideoTimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _videosRepository;
  List<VideoModel> _videoList = [];

  @override
  FutureOr<List<VideoModel>> build() async {
    _videosRepository = ref.read(videosRepository);
    final result = await _videosRepository.fetchVideos();
    _videoList =
        result.docs.map((doc) => VideoModel.fromJson(doc.data())).toList();
    return _videoList;
  }
}

final videoTimelineProvider =
    AsyncNotifierProvider<VideoTimelineViewModel, List<VideoModel>>(
  () => VideoTimelineViewModel(),
);

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/features/videos/view_models/video_timeline_vm.dart';
import 'package:tiktok_flutter/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  final PageController _pageController = PageController();

  final Map<String, dynamic> _scrollAnimation = {
    'duration': const Duration(milliseconds: 200),
    'curve': Curves.fastOutSlowIn
  };

  int _itemCount = 0;

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollAnimation['duration'],
      curve: _scrollAnimation['curve'],
    );
    if (page == _itemCount - 1) {
      // request more videos
      ref.watch(videoTimelineProvider.notifier).fetchNextPage();
    }
  }

  void _onVideoFinished() {
    return;
    _pageController.nextPage(
      duration: _scrollAnimation['duration'],
      curve: _scrollAnimation['curve'],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return ref.read(videoTimelineProvider.notifier).refresh();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return ref.watch(videoTimelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              'Could not load video: $error',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          data: (videos) {
            _itemCount = videos.length;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              displacement: Sizes.size52,
              edgeOffset: Sizes.size20,
              color: Theme.of(context).primaryColor,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                onPageChanged: _onPageChanged,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final videoData = videos[index];
                  return VideoPost(
                    onVideoFinished: _onVideoFinished,
                    videoIndex: index,
                    videoData: videoData,
                  );
                },
              ),
            );
          },
        );
  }
}

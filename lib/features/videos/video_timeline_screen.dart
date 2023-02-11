import 'package:flutter/material.dart';
import 'package:tiktok_flutter/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  final PageController _pageController = PageController();

  final Map<String, dynamic> _scrollAnimation = {
    'duration': const Duration(milliseconds: 200),
    'curve': Curves.fastOutSlowIn
  };

  int _itemCount = 4;

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollAnimation['duration'],
      curve: _scrollAnimation['curve'],
    );
    if (page == _itemCount - 1) {
      _itemCount += 4;
      setState(() {});
    }
  }

  void _onVideoFinished() {
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

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      itemCount: _itemCount,
      itemBuilder: (context, index) => VideoPost(
        onVideoFinished: _onVideoFinished,
        videoIndex: index,
      ),
    );
  }
}

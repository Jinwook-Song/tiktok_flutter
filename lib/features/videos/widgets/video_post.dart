import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int videoIndex;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.videoIndex,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;
  late final AnimationController _animationController;

  bool isPaused = false;

  final Duration _animationDuration = const Duration(milliseconds: 150);

  void _onVideoChanged() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.asset(
      'assets/videos/yeonjae_0${widget.videoIndex % 6 + 1}.MP4',
    );
    await _videoPlayerController.initialize();
    setState(() {});
    _videoPlayerController.addListener(_onVideoChanged);
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
      lowerBound: 1,
      upperBound: 1.5,
      value: 1.5, // start point
    );
    _animationController.addListener(
      () => {setState(() {})}, // call build method
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  void _onTogglePlay() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse(); // upper to lower
      isPaused = true;
    } else {
      _videoPlayerController.play();
      _animationController.forward(); // lower to upper
      isPaused = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('${widget.videoIndex}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
              child: GestureDetector(
            onTap: _onTogglePlay,
          )),
          Positioned.fill(
              child: IgnorePointer(
            child: Transform.scale(
              scale: _animationController.value,
              child: AnimatedOpacity(
                opacity: isPaused ? 1 : 0,
                duration: _animationDuration,
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.play,
                    size: Sizes.size52,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

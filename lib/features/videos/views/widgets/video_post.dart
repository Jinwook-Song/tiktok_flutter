import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/features/videos/models/video_model.dart';
import 'package:tiktok_flutter/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_flutter/features/videos/views/widgets/video_button.dart';
import 'package:tiktok_flutter/features/videos/views/widgets/video_comments.dart';
import 'package:tiktok_flutter/features/videos/views/widgets/video_like_button.dart';
import 'package:tiktok_flutter/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final int videoIndex;
  final VideoModel videoData;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.videoIndex,
    required this.videoData,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;
  late final AnimationController _animationController;

  bool _isPaused = false;
  late bool _isMuted = ref.read(playbackConfigProvider).muted;

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
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
    }
    _videoPlayerController.setVolume(_isMuted ? 0 : 1);
    _videoPlayerController.addListener(_onVideoChanged);
    setState(() {});
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
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;

    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _isMuted = ref.read(playbackConfigProvider).muted;
      if (ref.read(playbackConfigProvider).autoPlay) {
        _videoPlayerController.play();
      } else {
        _isPaused = true;
        setState(() {});
      }
    }

    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePlay();
      _videoPlayerController.seekTo(const Duration(seconds: 0));
    }
  }

  void _onToggleMute() {
    if (!mounted) return;
    _isMuted = !_isMuted;
    _videoPlayerController.setVolume(_isMuted ? 0 : 1);
    setState(() {});
  }

  void _onTogglePlay() {
    if (!mounted) return;

    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse(); // upper to lower
      _isPaused = true;
    } else {
      _videoPlayerController.play();
      _animationController.forward(); // lower to upper
      _isPaused = false;
    }
    setState(() {});
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePlay();
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const VideoComments(),
    );
    // when modal closed.
    _onTogglePlay();
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
                : Image.network(
                    widget.videoData.thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned.fill(
              child: GestureDetector(
            onTap: _onTogglePlay,
          )),
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                // animation value를 감지하여 build 실행
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animationController.value,
                    child: child, // AnimatedOpacity
                  );
                },
                child: AnimatedOpacity(
                  opacity: _isPaused ? 1 : 0,
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
            ),
          ),
          Positioned(
              top: Sizes.size40,
              left: Sizes.size14,
              child: IconButton(
                onPressed: _onToggleMute,
                icon: FaIcon(
                  _isMuted
                      ? FontAwesomeIcons.volumeOff
                      : FontAwesomeIcons.volumeHigh,
                  color: Colors.white,
                ),
              )),
          Positioned(
            bottom: Sizes.size20,
            left: Sizes.size14,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@${widget.videoData.creator}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Text(
                  widget.videoData.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size14,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Positioned(
              bottom: Sizes.size20,
              right: Sizes.size14,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: Sizes.size24,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    foregroundImage: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/tiktok-jw.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media',
                    ),
                    child: Text(
                      widget.videoData.creator,
                      style: const TextStyle(fontSize: Sizes.size8),
                    ),
                  ),
                  Gaps.v24,
                  VideoLikedButton(
                    videoId: widget.videoData.id,
                    likes: widget.videoData.likes,
                  ),
                  Gaps.v24,
                  GestureDetector(
                    onTap: () => _onCommentsTap(context),
                    child: VideoButton(
                      icon: FontAwesomeIcons.solidComment,
                      text: S
                          .of(context)
                          .videoCommentCount(widget.videoData.comments),
                    ),
                  ),
                  Gaps.v24,
                  const VideoButton(
                    icon: FontAwesomeIcons.share,
                    text: 'Share',
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

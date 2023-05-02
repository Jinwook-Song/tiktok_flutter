import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tiktok_flutter/features/videos/view_models/upload_video_vm.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  final XFile video;
  final bool isFromGallery;

  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isFromGallery,
  });

  @override
  VideoPreviewScreenState createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;

  bool _savedVideo = false;
  bool _isUploaded = false;

  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await _videoPlayerController.initialize();

    await _videoPlayerController.setLooping(false);

    await _videoPlayerController.play();

    // build method가 상태 변화를 알도록
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  Future<void> _saveToGallery() async {
    _savedVideo = true;
    setState(() {});

    await GallerySaver.saveVideo(
      widget.video.path,
      albumName: "TikTok!",
    );

    if (_savedVideo) return;
  }

  void _onUploadPressed() {
    if (ref.watch(uploadVideoProvider).isLoading) return;
    ref.read(uploadVideoProvider.notifier).uploadVideo(
          File(widget.video.path),
          context,
        );
    _isUploaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            'Preview video',
          ),
          actions: [
            if (!widget.isFromGallery)
              IconButton(
                onPressed: _saveToGallery,
                icon: FaIcon(
                  _savedVideo
                      ? FontAwesomeIcons.check
                      : FontAwesomeIcons.download,
                ),
              ),
            if (_isUploaded && !ref.watch(uploadVideoProvider).isLoading)
              IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.check,
                ),
              )
            else
              IconButton(
                onPressed: _onUploadPressed,
                icon: ref.watch(uploadVideoProvider).isLoading
                    ? const CircularProgressIndicator.adaptive()
                    : const FaIcon(
                        FontAwesomeIcons.cloudArrowUp,
                      ),
              )
          ],
        ),
        body: _videoPlayerController.value.isInitialized
            ? VideoPlayer(_videoPlayerController)
            : null);
  }
}

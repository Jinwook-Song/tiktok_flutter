import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  final XFile video;
  final bool isFromGallery;

  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isFromGallery,
  });

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;

  bool _savedVideo = false;

  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await _videoPlayerController.initialize();

    await _videoPlayerController.setLooping(true);

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
          ],
        ),
        body: _videoPlayerController.value.isInitialized
            ? VideoPlayer(_videoPlayerController)
            : null);
  }
}

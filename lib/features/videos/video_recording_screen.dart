import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_flutter/constants/gaps.dart';
import 'package:tiktok_flutter/constants/sizes.dart';
import 'package:tiktok_flutter/features/videos/video_preview_screen.dart';
import 'package:tiktok_flutter/features/videos/widgets/video_flash_button.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin {
  bool _hasPermission = false;

  bool _isSelfieMode = false;

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 150,
    ),
  );

  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 10,
    ),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  late final Animation<double> _buttonAniation = Tween(
    begin: 1.0,
    end: 0.9,
  ).animate(_buttonAnimationController);

  late FlashMode _flashMode;

  late CameraController _cameraController;

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    // only for IOS
    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final microphonePermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final microphoneDenied = microphonePermission.isDenied ||
        microphonePermission.isPermanentlyDenied;

    if (!cameraDenied && !microphoneDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(video: video),
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission || !_cameraController.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Initializing...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v28,
                  CircularProgressIndicator.adaptive()
                ],
              )
            : SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CameraPreview(
                      _cameraController,
                    ),
                    Positioned(
                      top: Sizes.size12,
                      right: Sizes.size12,
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            onPressed: _toggleSelfieMode,
                            icon: const Icon(
                              Icons.cameraswitch_rounded,
                            ),
                          ),
                          Gaps.v10,
                          VideoFlashButton(
                              color: _flashMode == FlashMode.off
                                  ? Colors.amber
                                  : Colors.white,
                              onpressedFn: () => _setFlashMode(FlashMode.off),
                              icon: Icons.flash_off_rounded),
                          Gaps.v10,
                          VideoFlashButton(
                              color: _flashMode == FlashMode.always
                                  ? Colors.amber
                                  : Colors.white,
                              onpressedFn: () =>
                                  _setFlashMode(FlashMode.always),
                              icon: Icons.flash_on_rounded),
                          Gaps.v10,
                          VideoFlashButton(
                              color: _flashMode == FlashMode.auto
                                  ? Colors.amber
                                  : Colors.white,
                              onpressedFn: () => _setFlashMode(FlashMode.auto),
                              icon: Icons.flash_auto_rounded),
                          Gaps.v10,
                          VideoFlashButton(
                              color: _flashMode == FlashMode.torch
                                  ? Colors.amber
                                  : Colors.white,
                              onpressedFn: () => _setFlashMode(
                                    _flashMode == FlashMode.torch
                                        ? FlashMode.off
                                        : FlashMode.torch,
                                  ),
                              icon: Icons.flashlight_on_rounded),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: Sizes.size20,
                      child: GestureDetector(
                        onTapDown: _startRecording,
                        onTapUp: (details) => _stopRecording(),
                        child: ScaleTransition(
                          scale: _buttonAniation,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: Sizes.size72,
                                height: Sizes.size72,
                                child: CircularProgressIndicator(
                                  color: Colors.red.shade400,
                                  strokeWidth: Sizes.size6,
                                  value: _progressAnimationController.value,
                                ),
                              ),
                              Container(
                                width: Sizes.size60,
                                height: Sizes.size60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

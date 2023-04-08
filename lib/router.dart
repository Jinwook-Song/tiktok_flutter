import 'package:go_router/go_router.dart';
import 'package:tiktok_flutter/features/videos/video_recording_screen.dart';
import 'package:tiktok_flutter/routes.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.SignupScreen,
      builder: (context, state) => const VideoRecordingScreen(),
    ),
  ],
);

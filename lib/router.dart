import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_flutter/common/widget/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_flutter/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_flutter/features/authentication/views/login_screen.dart';
import 'package:tiktok_flutter/features/authentication/views/sign_up_screen.dart';
import 'package:tiktok_flutter/features/inbox/activity_screen.dart';
import 'package:tiktok_flutter/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_flutter/features/inbox/chats_screen.dart';
import 'package:tiktok_flutter/features/onboarding/interests_screen.dart';
import 'package:tiktok_flutter/features/videos/views/video_recording_screen.dart';
import 'package:tiktok_flutter/routes.dart';

final routerProvider = Provider((ref) {
  // authState가 변하면 rebuild된다
  // ref.watch(authState);

  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final isLoggedIn = ref.read(authenticationRepository).isLoggedIn;
      if (!isLoggedIn) {
        if (state.subloc != Routes.signUpScreen['url'] &&
            state.subloc != Routes.logInScreen['url']) {
          return Routes.signUpScreen['url'];
        }
      }
      return null;
    },
    routes: [
      // ❌ Login
      GoRoute(
        name: Routes.signUpScreen['name'],
        path: Routes.signUpScreen['url']!,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: Routes.logInScreen['name'],
        path: Routes.logInScreen['url']!,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: Routes.interestsScreen['name'],
        path: Routes.interestsScreen['url']!,
        builder: (context, state) => const InterestsScreen(),
      ),
      // ✅ Login
      GoRoute(
        name: Routes.mainNavigationScreen['name'],
        path: Routes.mainNavigationScreen['url']!,
        builder: (context, state) {
          final tab = state.params['tab'] ?? 'home';
          return MainNavigationScreen(tab: tab);
        },
      ),
      GoRoute(
        name: Routes.activityScreen['name'],
        path: Routes.activityScreen['url']!,
        builder: (context, state) => const ActivityScreen(),
      ),
      GoRoute(
        name: Routes.chatsScreen['name'],
        path: Routes.chatsScreen['url']!,
        builder: (context, state) => const ChatsScreen(),
        routes: [
          GoRoute(
            name: Routes.chatDetailScreen['name'],
            path: Routes.chatDetailScreen['url']!,
            builder: (context, state) {
              final chatId = state.params['chatId']!;
              return ChatDetailScreen(chatId: chatId);
            },
          ),
        ],
      ),
      GoRoute(
        name: Routes.videoRecordingScreen['name'],
        path: Routes.videoRecordingScreen['url']!,
        pageBuilder: (context, state) => CustomTransitionPage(
            child: const VideoRecordingScreen(),
            transitionDuration: const Duration(milliseconds: 150),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final position = Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation);
              return SlideTransition(
                position: position,
                child: child,
              );
            }),
      ),
    ],
  );
});

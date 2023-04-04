import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_flutter/features/authentication/email_screen.dart';
import 'package:tiktok_flutter/features/authentication/login_screen.dart';
import 'package:tiktok_flutter/features/authentication/sign_up_screen.dart';
import 'package:tiktok_flutter/features/authentication/username_screen.dart';
import 'package:tiktok_flutter/features/users/user_profile_screen.dart';
import 'package:tiktok_flutter/routes.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.SignupScreen,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: Routes.LoginScreen,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.UserNameScreen,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const UserNameScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
    GoRoute(
      path: Routes.EmailSignupScreen,
      builder: (context, state) {
        final args = state.extra as EmailScreenArgs;
        return EmailScreen(
          username: args.username,
        );
      },
    ),
    GoRoute(
      path: '/users/:username',
      builder: (context, state) {
        final username = state.params['username'];
        final query = state.queryParams['show'];
        return UserProfileScreen(
          username: username ?? 'anonymous',
        );
      },
    ),
  ],
);

import 'package:go_router/go_router.dart';
import 'package:tiktok_flutter/features/authentication/login_screen.dart';
import 'package:tiktok_flutter/features/authentication/sign_up_screen.dart';
import 'package:tiktok_flutter/features/onboarding/interests_screen.dart';
import 'package:tiktok_flutter/routes.dart';

final GoRouter router = GoRouter(
  routes: [
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
  ],
);

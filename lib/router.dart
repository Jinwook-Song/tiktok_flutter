import 'package:go_router/go_router.dart';
import 'package:tiktok_flutter/common/widget/main_navigation/main_navigation_screen.dart';
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
    GoRoute(
      name: Routes.mainNavigationScreen['name'],
      path: Routes.mainNavigationScreen['url']!,
      builder: (context, state) {
        final tab = state.params['tab'] ?? 'home';
        return MainNavigationScreen(tab: tab);
      },
    ),
  ],
);

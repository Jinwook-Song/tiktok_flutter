class Routes {
  // ❌ Login
  static const signUpScreen = {
    'name': 'signUp',
    'url': '/',
  };

  static const logInScreen = {
    'name': 'logIn',
    'url': '/login',
  };

  static const interestsScreen = {
    'name': 'interests',
    'url': '/tutorial',
  };

  // ✅ Login
  static const mainNavigationScreen = {
    'name': 'mainNavigation',
    'url': '/:tab(home|discover|inbox|profile)',
  };
}

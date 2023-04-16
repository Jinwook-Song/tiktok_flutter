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

  static const activityScreen = {
    'name': 'activity',
    'url': '/activity',
  };

  static const chatsScreen = {
    'name': 'chats',
    'url': '/chats',
  };

  static const chatDetailScreen = {
    'name': 'chatDetail',
    'url': ':chatId',
  };

  static const videoRecordingScreen = {
    'name': 'recordVideo',
    'url': '/upload',
  };
}

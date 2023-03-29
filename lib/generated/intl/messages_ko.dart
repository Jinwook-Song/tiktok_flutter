// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ko';

  static String m0(gender) => "Log in";

  static String m1(appName) => "${appName}에 로그인하세요";

  static String m2(videoCount) =>
      "Create a profile, follow other accounts, make your own videos, and more.";

  static String m3(appName) => "${appName}에 가입하세요";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "alreadyHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "appleSignUpButton":
            MessageLookupByLibrary.simpleMessage("Continue with Apple"),
        "emailPasswordSignUpButton":
            MessageLookupByLibrary.simpleMessage("Use email & password"),
        "logIn": m0,
        "loginTitle": m1,
        "signUpSubTitle": m2,
        "signUpTitle": m3
      };
}
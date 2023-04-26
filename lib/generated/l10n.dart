// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign up for {appName} {when}`
  String signUpTitle(String appName, DateTime when) {
    final DateFormat whenDateFormat =
        DateFormat('QQQ / LLLL', Intl.getCurrentLocale());
    final String whenString = whenDateFormat.format(when);

    return Intl.message(
      'Sign up for $appName $whenString',
      name: 'signUpTitle',
      desc: 'The title people see when they open the app for the first time.',
      args: [appName, whenString],
    );
  }

  /// `Log in to {appName}`
  String loginTitle(String appName) {
    return Intl.message(
      'Log in to $appName',
      name: 'loginTitle',
      desc: 'The title people see when they open the log in screen.',
      args: [appName],
    );
  }

  /// `Create a profile, follow other accounts, make your own {videoCount, plural, =0{no videos} =1{video} other{videos}}, and more.`
  String signUpSubTitle(num videoCount) {
    return Intl.message(
      'Create a profile, follow other accounts, make your own ${Intl.plural(videoCount, zero: 'no videos', one: 'video', other: 'videos')}, and more.',
      name: 'signUpSubTitle',
      desc: '',
      args: [videoCount],
    );
  }

  /// `Use email & password`
  String get emailPasswordSignUpButton {
    return Intl.message(
      'Use email & password',
      name: 'emailPasswordSignUpButton',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Github`
  String get githubSignUpButton {
    return Intl.message(
      'Continue with Github',
      name: 'githubSignUpButton',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log in {gender, select, male{sir} female{madam} other{human}}`
  String logIn(String gender) {
    return Intl.message(
      'Log in ${Intl.gender(gender, male: 'sir', female: 'madam', other: 'human')}',
      name: 'logIn',
      desc: '',
      args: [gender],
    );
  }

  /// `{value}`
  String videoLikeCount(int value) {
    final NumberFormat valueNumberFormat = NumberFormat.compact(
      locale: Intl.getCurrentLocale(),
    );
    final String valueString = valueNumberFormat.format(value);

    return Intl.message(
      '$valueString',
      name: 'videoLikeCount',
      desc: 'Video like count',
      args: [valueString],
    );
  }

  /// `{value}`
  String videoCommentCount(int value) {
    final NumberFormat valueNumberFormat = NumberFormat.compact(
      locale: Intl.getCurrentLocale(),
    );
    final String valueString = valueNumberFormat.format(value);

    return Intl.message(
      '$valueString',
      name: 'videoCommentCount',
      desc: 'Video comment count',
      args: [valueString],
    );
  }

  /// `{value} {value2, plural, =1{comment} other{comments}}`
  String videoCommentTitle(int value, num value2) {
    final NumberFormat valueNumberFormat = NumberFormat.compact(
      locale: Intl.getCurrentLocale(),
    );
    final String valueString = valueNumberFormat.format(value);

    return Intl.message(
      '$valueString ${Intl.plural(value2, one: 'comment', other: 'comments')}',
      name: 'videoCommentTitle',
      desc: 'Video comment title',
      args: [valueString, value2],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ko'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

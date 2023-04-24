import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}

void showFirebaseErrorSnack(BuildContext context, Object error) {
  final snackBar = SnackBar(
    content: Text(
      (error as FirebaseException).message ?? 'Something went wrong',
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

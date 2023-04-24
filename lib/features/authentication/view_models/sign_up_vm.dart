import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_flutter/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_flutter/routes.dart';
import 'package:tiktok_flutter/utils.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<void> build() {
    _authenticationRepository = ref.read(authenticationRepository);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpFormProvider);

    // error handling (내부적으로 try catch 사용)
    state = await AsyncValue.guard(
      () async => await _authenticationRepository.emailSignUp(
        form['email'],
        form['password'],
      ),
    );

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error!);
    } else {
      context.goNamed(Routes.interestsScreen['name']!);
    }
  }
}

final signUpFormProvider = StateProvider(
  (ref) => {},
);

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_flutter/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_flutter/features/users/view_models/user_vm.dart';
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
    final user = ref.read(userProvider.notifier);
    state = await AsyncValue.guard(
      () async {
        final userCredential = await _authenticationRepository.emailSignUp(
          form['email'],
          form['password'],
        );
        await user.createProfile(userCredential);
      },
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

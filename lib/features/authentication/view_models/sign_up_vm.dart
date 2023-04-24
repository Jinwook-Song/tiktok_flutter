import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/authentication/repositories/authentication_repository.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<void> build() {
    _authenticationRepository = ref.read(authenticationRepository);
  }

  Future<void> signUp() async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpFormProvider);

    // error handling (내부적으로 try catch 사용)
    state = await AsyncValue.guard(
      () async => await _authenticationRepository.signUp(
        form['email'],
        form['password'],
      ),
    );
  }
}

final signUpFormProvider = StateProvider(
  (ref) => {},
);

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);

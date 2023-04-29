import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_flutter/features/users/repositories/user_repository.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _userRepository;

  @override
  FutureOr<void> build() {
    _userRepository = ref.read(userRepository);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final fileName = ref.read(authenticationRepository).user!.uid;

    state = await AsyncValue.guard(
      () async => await _userRepository.uploadAvatar(file, fileName),
    );
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_flutter/features/authentication/view_models/sign_up_vm.dart';
import 'package:tiktok_flutter/features/users/models/user_profile_model.dart';
import 'package:tiktok_flutter/features/users/repositories/user_repository.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepository);
    _authenticationRepository = ref.read(authenticationRepository);

    if (_authenticationRepository.isLoggedIn) {
      final profile = await _userRepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    if (credential.user == null) {
      throw Exception('Account not created');
    }
    state = const AsyncValue.loading();
    final additionalCredentials = ref.read(signUpFormProvider);
    final profile = UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email!,
      name: additionalCredentials['name'] ?? 'Anonymous',
      bio: additionalCredentials['bio'] ?? 'undefined',
      link: additionalCredentials['link'] ?? 'undefined',
    );
    await _userRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final userProvider = AsyncNotifierProvider<UserViewModel, UserProfileModel>(
  () => UserViewModel(),
);

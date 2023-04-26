import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/authentication/view_models/sign_up_vm.dart';
import 'package:tiktok_flutter/features/users/models/user_profile_model.dart';
import 'package:tiktok_flutter/features/users/repositories/user_repository.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _repository;

  @override
  FutureOr<UserProfileModel> build() {
    _repository = ref.read(userRepository);
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
    await _repository.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final userProvider = AsyncNotifierProvider<UserViewModel, UserProfileModel>(
  () => UserViewModel(),
);

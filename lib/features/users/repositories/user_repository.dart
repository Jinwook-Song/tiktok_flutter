import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _firestore //
        .collection('users')
        .doc(profile.uid)
        .set(profile.toJson());
  }
}

final userRepository = Provider(
  (ref) => UserRepository(),
);

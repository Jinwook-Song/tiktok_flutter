import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_flutter/features/inbox/models/message_model.dart';
import 'package:tiktok_flutter/features/inbox/repositories/messages_repository.dart';

class MessageViewModel extends AsyncNotifier<void> {
  late final MessagesRepository _repository;

  @override
  FutureOr build() {
    _repository = ref.read(messagesRepository);
  }

  Future<void> sendMessage(String text) async {
    final uid = ref.read(authenticationRepository).user!.uid;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final message = MessageModel(
          text: text,
          uid: uid,
        );
        _repository.sendMessage(message: message);
      },
    );
  }
}

final messageProvider = AsyncNotifierProvider<MessageViewModel, void>(
  () => MessageViewModel(),
);

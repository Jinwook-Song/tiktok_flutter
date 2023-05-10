import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
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
            createdAt: DateTime.now().millisecondsSinceEpoch);
        _repository.sendMessage(message: message);
      },
    );
  }
}

final messageProvider = AsyncNotifierProvider<MessageViewModel, void>(
  () => MessageViewModel(),
);

// riverpod은 위젯트리 외부에 있으므로 반드시 dispose를 해야한다 (채팅방을 나가면 stop listening)
final chatProvider = StreamProvider.autoDispose<List<MessageModel>>(
  (ref) {
    final firestore = FirebaseFirestore.instance;

    // snapshots : get과 다르게 변경사항이 발생하면 알림을 준다. (collection의 상태를 알 수 있음)
    return firestore
        .collection('chatRooms')
        .doc('qVd1a1gP6KMtbGGvYWUu')
        .collection('texts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        // sanpshot을 원하는 데이터 형태로 변경
        .map(
          (event) => event.docs
              .map(
                (doc) => MessageModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  },
);

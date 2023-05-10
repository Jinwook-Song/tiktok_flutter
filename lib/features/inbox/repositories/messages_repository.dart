import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_flutter/features/inbox/models/message_model.dart';

class MessagesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage({
    required MessageModel message,
    String chatRoomId = 'qVd1a1gP6KMtbGGvYWUu', // TODO: chat room
  }) async {
    await _firestore
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('texts')
        .add(message.toJson());
  }
}

final messagesRepository = Provider(
  (ref) => MessagesRepository(),
);

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serina/features/chatbox/domain/entity/chat_entity.dart';
import 'package:serina/helper/extensions/chat_extensions.dart';
import 'package:serina/sources/api/chatbot_api_service.dart';
import 'package:serina/sources/firestore/firestore_service.dart';

abstract class ChatRepositoryAbs {
  Future<ChatEntity> sendQuestion({
    required int k,
    required String query,
    required String topic,
    required String uid,
  });

  Stream<List<ChatEntity>> streamChat({
    required String uid,
    required String sessionId,
  });

  Future<void> storeChat({
    required ChatEntity chats,
    required String userId,
    required String sessionId,
  });
}

class ChatRepository implements ChatRepositoryAbs {
  final FirebaseFirestore firestore;
  late final FirestoreService _firestoreService =
      FirestoreService(firestore: firestore);
  late final ChatbotApiService _chatbotApiService = ChatbotApiService();

  ChatRepository({required this.firestore});

  @override
  Future<ChatEntity> sendQuestion(
      {required String uid,
      required int k,
      required String query,
      required String topic}) async {
    try {
      final response = await _chatbotApiService.sendQuestion(
        uid: uid,
        k: k,
        inputQuery: query,
        lastTopicIssue: topic,
      );

      return ChatEntity(
        msg: response.answer,
        time: DateTime.now(),
        topic: response.topicIssue,
        isMe: false,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<ChatEntity>> streamChat({
    required String uid,
    required String sessionId,
  }) {
    try {
      return _firestoreService
          .streamConversation(uid: uid, sessionId: sessionId)
          .map((event) => event
              .map(
                (e) => ChatEntity(
                  msg: e.value,
                  isMe: e.isMe,
                  time: e.time,
                ),
              )
              .toList());
      // _firestoreService
      //     .streamConversation(uid: uid, sessionId: sessionId)
      //     .listen((event) {
      //   onChange(event
      //       .map((e) => ChatEntity(isMe: e.isMe, msg: e.value, time: e.time, topic: "-")).toList());
      // });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> storeChat({
    required ChatEntity chats,
    required String userId,
    required String sessionId,
  }) async {
    try {
      await _firestoreService.storeChat(
        userId: userId,
        sessionId: sessionId,
        data: chats.toFirestoreModel(),
      );
    } catch (e) {
      rethrow;
    }
  }
}

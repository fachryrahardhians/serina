import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serina/features/chatbox/domain/entity/chat_entity.dart';
import 'package:serina/features/chatbox/domain/repository/chat_repository.dart';

abstract class _ChatUsecaseAbs {
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

  Future<void> storeSession({
    required String topic,
    required String userId,
    required String sessionId,
  });
}

class ChatUsecase implements _ChatUsecaseAbs {
  final FirebaseFirestore firestore;
  late final ChatRepository _repository = ChatRepository(firestore: firestore);

  ChatUsecase({required this.firestore});

  @override
  Future<ChatEntity> sendQuestion({
    required int k,
    required String query,
    required String topic,
    required String uid,
  }) async {
    try {
      final result = await _repository.sendQuestion(
          uid: uid, k: k, query: query, topic: topic);
      return result;
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
      return _repository.streamChat(uid: uid, sessionId: sessionId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> storeChat(
      {required ChatEntity chats,
      required String userId,
      required String sessionId}) async {
    try {
      await _repository.storeChat(
          chats: chats, userId: userId, sessionId: sessionId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> storeSession(
      {required String topic,
      required String userId,
      required String sessionId}) async {
    try {
      await _repository.storeSession(
          topic: topic, userId: userId, sessionId: sessionId);
    } catch (e) {
      rethrow;
    }
  }
}

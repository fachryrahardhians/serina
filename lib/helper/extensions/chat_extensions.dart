import 'package:serina/features/chatbox/domain/entity/chat_entity.dart';
import 'package:serina/sources/firestore/model/firestore_chat_model.dart';

extension ChatEntityExtension on ChatEntity {
  FirestoreChatModel toFirestoreModel() => FirestoreChatModel(
    value: msg,
    isMe: isMe,
    time: time,
  );
}

extension FirestoreChatModelExtension on FirestoreChatModel {
  ChatEntity toChatEntity() => ChatEntity(
    isMe: isMe,
    msg: value,
    time: time,
  );
}
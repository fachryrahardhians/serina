import 'package:equatable/equatable.dart';
import 'package:serina/features/chatbox/domain/entity/chat_entity.dart';
import 'package:serina/features/chatbox/domain/entity/question_payload_entity.dart';

abstract class ChatEvent extends Equatable {}

class InitiateConversation extends ChatEvent {
  final String? userId;
  final String? sessionId;

  InitiateConversation({this.userId, this.sessionId});

  @override
  List<Object?> get props => [userId, sessionId];
}

class ChangeSession extends ChatEvent {
  @override
  List<Object?> get props => [];
}

class SendMessageEvent extends ChatEvent {
  // final QuestionPayloadEntity payload;
  final String? payload;

  SendMessageEvent({
    required this.payload,
  });

  @override
  List<Object?> get props => [payload];
}

class UpdateConversation extends ChatEvent {
  final ChatEntity chat;

  UpdateConversation({required this.chat});

  @override
  List<Object?> get props => [
        chat,
      ];
}

class StreamedChats extends ChatEvent {
  final List<ChatEntity> chats;

  StreamedChats({required this.chats});

  @override
  List<Object?> get props => [chats];
}

class StoreMessage extends ChatEvent {
  // final String userId;
  // final String sessionId;
  final ChatEntity chat;

  StoreMessage({
    // required this.userId,
    // required this.sessionId,
    required this.chat,
  });

  @override
  List<Object?> get props => [
        // userId,
        // sessionId,
        chat,
      ];
}

class StoreSession extends ChatEvent {
  final String? topic;

  StoreSession({
    this.topic,
  });

  @override
  List<Object?> get props => [
        topic,
      ];
}

class StreamMessage extends ChatEvent {
  @override
  List<Object?> get props => [];
}

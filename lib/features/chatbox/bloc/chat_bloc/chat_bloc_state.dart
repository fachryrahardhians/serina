import 'package:equatable/equatable.dart';
import 'package:serina/common/entities/state_status_entity.dart';
import 'package:serina/features/chatbox/domain/entity/chat_entity.dart';

class ChatState extends Equatable {
  final StateStatus? messageStatus;
  final List<ChatEntity>? chats;
  final String? lastTopic;
  final int? lastK;

  const ChatState.__({
    this.chats,
    this.messageStatus,
    this.lastK,
    this.lastTopic,
  });

  const ChatState.initial()
      : this.__(
          chats: const <ChatEntity>[],
          messageStatus: StateStatus.init,
          lastTopic: '-',
          lastK: 0,
        );

  ChatState copyWith({
    StateStatus? messageStatus,
    List<ChatEntity>? chats,
    String? lastTopic,
    int? lastK,
  }) =>
      ChatState.__(
        chats: chats ?? this.chats,
        messageStatus: messageStatus ?? this.messageStatus,
        lastK: lastK ?? this.lastK,
        lastTopic: lastTopic ?? this.lastTopic,
      );

  ChatState changeMessageStatus({required StateStatus status, String?
  lastTopic}) =>
      copyWith(
        messageStatus: status,
        lastTopic: lastTopic,
        lastK: lastK == null ? 0 : lastK! + 1,
      );

  ChatState updateConversation({required ChatEntity lastChat}){
    try{
      List<ChatEntity> updatedChat = List<ChatEntity>.from(chats ?? <ChatEntity>[]);
      updatedChat.add(lastChat);
      print("STATE UPDATED");
      return copyWith(
        chats: updatedChat,
      );
    }catch(e){
      throw e;
    }
  }

  ChatState streamedChats({required List<ChatEntity> chats}) => copyWith(
    chats: chats,
  );

  @override
  List<Object?> get props => [
        messageStatus,
        chats,
        lastTopic,
        lastK,
      ];


}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serina/common/entities/state_status_entity.dart';
import 'package:serina/features/chatbox/domain/entity/chat_entity.dart';
import 'package:serina/features/chatbox/domain/usecase/chat_usecase.dart';
import 'package:serina/sources/api/chatbot_api_service.dart';
import 'package:serina/sources/firestore/firestore_service.dart';
import 'package:serina/sources/firestore/model/firestore_chat_model.dart';

import 'chat_bloc_event.dart';
import 'chat_bloc_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc()
      : _usecase = ChatUsecase(
          firestore: FirebaseFirestore.instance,
        ),
        super(
          const ChatState.initial(),
        ) {
    ///streaming chat from firebase firestore
    _chatSubscription = _usecase
        .streamChat(
      uid: "dummyUserId",
      sessionId: "dummySessionId",
    )
        .listen((event) {
      add(StreamedChats(chats: event));
    });

    on<SendMessageEvent>((event, emit) => _sendMessage(event, emit));
    on<UpdateConversation>((event, emit) => _updateConversation(event, emit));
    on<StoreMessage>((event, emit) => _storeMessage(event, emit));
    on<StreamedChats>((event, emit) => _streamedChats(event, emit));
  }

  /// todo update to injection bloc
  // late final FirestoreService firestoreService;
  late final ChatUsecase _usecase;
  StreamSubscription<List<ChatEntity>>? _chatSubscription;

  _sendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      final result = await ChatbotApiService().sendQuestion(
        uid: "dummyUserId",
        k: state.lastK,
        inputQuery: event.payload,
        lastTopicIssue: state.lastTopic,
      );

      emit(
        state.changeMessageStatus(
          status: StateStatus.done,
          lastTopic: result.topicIssue,
        ),
      );
      // add(
      //   UpdateConversation(
      //     chat: ChatEntity(
      //       msg: result.answer,
      //       type: "A",
      //       topic: result.topicIssue,
      //     ),
      //   ),
      // );
      add(
        StoreMessage(
          userId: "userId",
          sessionId: "sessionId",
          chat: ChatEntity(
            msg: result.answer,
            isMe: false,
            topic: result.topicIssue,
          ),
        ),
      );
    } catch (e) {
      emit(state.changeMessageStatus(status: StateStatus.error));
    }
  }

  _storeMessage(StoreMessage event, Emitter<ChatState> emit) {
    try {
      // firestoreService.storeChat(
      //   userId: "dummyUserId",
      //   sessionId: "dummySessionId",
      //   chat: FirestoreChatModel(
      //     value: event.chat.msg!,
      //     isMe: event.chat.isMe!,
      //     time: DateTime.now(),
      //   ).toJson(),
      // );

      //todo user id dan session id perlu disimpan dan dikombinasi dengan
      //todo state agar tidak ambil dari parameter lagi
      _usecase.storeChat(
        chats: event.chat,
        userId: "dummyUserId",
        sessionId: "dummySessionId",
      );
    } catch (e) {
      debugPrint("SOMETHING WRONG WHEN SAVE MESSAGE $e");
    }
  }

  _updateConversation(UpdateConversation event, Emitter<ChatState> emit) {
    try {
      // print("UPDATE CONVERSATION TRIGGERED : ${event.chat.isMe}");
      emit(state.updateConversation(lastChat: event.chat));
      add(
        StoreMessage(
          userId: "userId",
          sessionId: "sessionId",
          chat: ChatEntity(
            msg: event.chat.msg,
            isMe: true,
            topic: event.chat.topic,
          ),
        ),
      );
    } catch (e) {}
  }

  _streamedChats(StreamedChats event, Emitter<ChatState> emit) {
    try {
      emit(state.streamedChats(chats: event.chats));
    } catch (e) {
      debugPrint("ERROR STREAM MASSAGE");
    }
  }
}

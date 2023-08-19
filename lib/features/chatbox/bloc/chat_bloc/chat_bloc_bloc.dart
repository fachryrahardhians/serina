import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:serina/common/entities/state_status_entity.dart';
import 'package:serina/config/constants.dart';
import 'package:serina/features/chatbox/domain/entity/chat_entity.dart';
import 'package:serina/features/chatbox/domain/usecase/chat_usecase.dart';
import 'package:serina/helper/random/random_gen_helper.dart';
import 'package:serina/helper/shared_pref_service/shared_preferences_services.dart';
import 'package:serina/helper/unique_identifier/unique_identifier_helper.dart';
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
    on<InitiateConversation>(
        (event, emit) => _initiateConversation(event, emit));
    on<SendMessageEvent>((event, emit) => _sendMessage(event, emit));
    on<StoreMessage>((event, emit) => _storeMessage(event, emit));
    on<StreamedChats>((event, emit) => _streamedChats(event, emit));
    on<ChangeSession>((event, emit) => _changeSession(event, emit));
  }

  /// todo update to injection bloc
  late final ChatUsecase _usecase;
  final LocalStorageService _localStorage = LocalStorageService();
  StreamSubscription<List<ChatEntity>>? _chatSubscription;

  _changeSession(ChangeSession event, Emitter<ChatState> emit) async {
    try {
      /// generate session id baru
      final sessionId = generateRandomString(selfGeneratedSessionIdLength);

      /// emit state session id yg baru
      emit(state.setIdentifier(sessionId: sessionId));

      /// set ganti subscribtion ke session id baru
      _setSubscribtion();
      await Future.delayed(Duration(seconds: 2));

      /// generate pesan pertama
      add(
        StoreMessage(
          // userId: state.userId!,
          // sessionId: state.sessionId!,
          chat: ChatEntity(
            msg: cWelcomeMessage,
            isMe: false,
            topic: "-",
            time: DateTime.now(),
          ),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  _initiateConversation(
      InitiateConversation event, Emitter<ChatState> emit) async {
    try {
      /// generate user id
      /// todo sementara generate user id
      final userId = await IdentifierHelper.getIdentifier();

      /// generate session id
      final sessionId = generateRandomString(selfGeneratedSessionIdLength);

      /// simpan userId & session id di sharedPreferences
      await _localStorage.put(PrefName.userId, userId);
      await _localStorage.put(PrefName.sessionId, sessionId);

      /// simpan user id di state
      emit(state.setIdentifier(userId: userId, sessionId: sessionId));

      /// generate pesan pertama
      add(
        StoreMessage(
          // userId: state.userId!,
          // sessionId: state.sessionId!,
          chat: ChatEntity(
            msg: cWelcomeMessage,
            isMe: false,
            topic: "-",
            time: DateTime.now(),
          ),
        ),
      );

      /// set start subscribtion
      _setSubscribtion();
    } catch (e) {
      debugPrint("ERROR INITIATE");
      rethrow;
    }
  }

  void _setSubscribtion() {
    _chatSubscription = _usecase
        .streamChat(
      uid: state.userId!,
      sessionId: state.sessionId!,
    )
        .listen((event) {
      add(StreamedChats(chats: event));
    });
  }

  _sendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      /// kirim pertanyaan ke firestore
      add(
        StoreMessage(
          // userId: state.userId!,
          // sessionId: state.sessionId!,
          chat: ChatEntity(
            msg: event.payload,
            isMe: true,
            topic: state.lastTopic,
            time: DateTime.now(),
          ),
        ),
      );

      /// kirim pertanyaan ke chatbot API
      final result = await ChatbotApiService().sendQuestion(
        uid: state.userId,
        k: state.lastK,
        inputQuery: event.payload,
        lastTopicIssue: state.lastTopic,
      );

      /// emit state
      emit(
        state.changeMessageStatus(
          status: StateStatus.done,
          lastTopic: result.topicIssue,
        ),
      );

      /// simpan balasan chat bot ke firestore
      add(
        StoreMessage(
          // userId: state.userId!,
          // sessionId: state.sessionId!,
          chat: ChatEntity(
            msg: result.answer,
            isMe: false,
            topic: result.topicIssue,
            time: DateTime.now(),
          ),
        ),
      );
    } catch (e) {
      emit(state.changeMessageStatus(status: StateStatus.error));
    }
  }

  _storeMessage(StoreMessage event, Emitter<ChatState> emit) {
    try {
      _usecase.storeChat(
        chats: event.chat,
        userId: state.userId!,
        sessionId: state.sessionId!,
      );
    } catch (e) {
      debugPrint("SOMETHING WRONG WHEN SAVE MESSAGE $e");
    }
  }

  _streamedChats(StreamedChats event, Emitter<ChatState> emit) {
    try {
      emit(state.streamedChats(chats: event.chats));
    } catch (e) {
      debugPrint("ERROR STREAM MASSAGE  === $e");
    }
  }

  @override
  Future<void> close() async {
    _chatSubscription?.cancel();
    return super.close();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serina/features/chatbox/bloc/chat_bloc/chat_bloc_bloc.dart';
import 'package:serina/features/chatbox/bloc/chat_bloc/chat_bloc_event.dart';
import 'package:serina/features/chatbox/view/component/chatting_page.dart';

class ChatboxPage extends StatelessWidget {
  ChatboxPage({Key? key, this.userId, this.sessionId, this.topic})
      : super(key: key);

  final String? userId;
  final String? sessionId;
  final String? topic;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc()
        ..add(InitiateConversation(
            userId: "4DpgLiu03lzN6WQjy", sessionId: sessionId)),
      child: ChatingPage(topic: topic),
    );
  }
}

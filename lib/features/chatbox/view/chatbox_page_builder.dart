import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:serina/features/chatbox/bloc/chat_bloc/chat_bloc_bloc.dart';
import 'package:serina/features/chatbox/bloc/chat_bloc/chat_bloc_event.dart';
import 'package:serina/features/chatbox/view/component/chatting_page.dart';

class ChatboxPage extends StatelessWidget {
  ChatboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc()..add(InitiateConversation()),
      child: ChatingPage(),
    );
  }
}

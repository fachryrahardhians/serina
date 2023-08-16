import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serina/common/color_palette/color_palette.dart';
import 'package:serina/features/chatbox/bloc/chat_bloc/chat_bloc_bloc.dart';
import 'package:serina/features/chatbox/bloc/chat_bloc/chat_bloc_event.dart';
import 'package:serina/features/chatbox/bloc/chat_bloc/chat_bloc_state.dart';
import 'package:serina/features/chatbox/domain/entity/chat_entity.dart';
import 'package:serina/features/chatbox/domain/entity/question_payload_entity.dart';
import 'package:serina/features/chatbox/view/component/chatbox_component.dart';
import 'package:serina/features/chatbox/view/component/chatting_page.dart';
import 'package:serina/sources/firestore/firestore_service.dart';

class ChatboxPage extends StatelessWidget {
  const ChatboxPage({Key? key}) : super(key: key);

  static  TextEditingController chatController = TextEditingController();
  static ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc()..add(InitiateConversation()),
      child: const ChatingPage(),
    );
  }
}

// List<ChatEntity> chats = [
//   ChatEntity(
//     type: "Q",
//     msg: "Hi there! How's the weather today?",
//   ),
//   ChatEntity(
//     type: "A",
//     msg:
//         "Hey! It's actually pretty nice outside. The sun is shining, and there's a gentle breeze.",
//   ),
//   ChatEntity(
//     type: "A",
//     msg:
//         "That sounds lovely! I was thinking of going for a walk later. Do you think it will rain?",
//   ),
//   ChatEntity(
//     type: "Q",
//     msg: "The weather forecast didn't mention any rain, "
//         "so you should be good to go.",
//   ),
//   ChatEntity(
//     type: "A",
//     msg: "Great! I'll grab my sunglasses and head out "
//         "then. By the way, have you heard about the weather forecast for tomorrow?",
//   ),
//   ChatEntity(
//     type: "Q",
//     msg:
//         "Not yet, but I'll check it out later. Why? Is there anything special happening tomorrow?",
//   ),
//   ChatEntity(
//     type: "A",
//     msg: "I'm planning a picnic with some friends, and I "
//         "really hope it stays sunny.",
//   ),
//   ChatEntity(
//     type: "Q",
//     msg:
//         "Oh, that sounds like a lot of fun! I'll keep my fingers crossed for clear skies for your picnic.",
//   ),
// ];

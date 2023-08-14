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
import 'package:serina/sources/firestore/firestore_service.dart';

class ChatboxPage extends StatelessWidget {
  ChatboxPage({Key? key}) : super(key: key);

  TextEditingController chatController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: ColorPalette.backgroudGrey,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 5,
              title: const Text(
                "SERINA",
                style: TextStyle(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            body: Column(
              children: [
                // Expanded(
                //     child: StreamBuilder(
                //   stream:
                //       FirestoreService(firestore: FirebaseFirestore.instance)
                //           .streamChat(
                //               userId: "dummyUserId",
                //               sessionId: "dummySessionId"),
                //   builder: (context, snapshot) {
                //     return ListView(
                //       physics: const BouncingScrollPhysics(),
                //       shrinkWrap: true,
                //       children: List<Widget>.generate(
                //         snapshot.data?.docs.length ?? 0,
                //         (index) => Builder(builder: (context) {
                //           return (snapshot.data?.docs[index]["isMe"] ?? false)
                //               ? ChatTileQ(
                //                   message: snapshot.data?.docs[index]['value'],
                //                 )
                //               : ChatTileA(
                //                   message: snapshot.data?.docs[index]['value'],
                //                 );
                //         }),
                //       ),
                //     );
                //     return Text(
                //         "${snapshot.hasData} ${snapshot.data?.docs.first.data()}");
                //   },
                // )),
                BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    return Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        // children: List<Widget>.generate(
                        //   chats.length,
                        //       (index) =>
                        //       Builder(builder: (context) {
                        //         return chats[index].type == "A"
                        //             ? ChatTileA(
                        //           message: chats[index].msg,
                        //         )
                        //             : ChatTileQ(
                        //           message: chats[index].msg,
                        //         );
                        //       }),
                        // ),
                        children: List<Widget>.generate(
                          state.chats?.length ?? 0,
                              (index) => Builder(builder: (context) {
                            return !(state.chats?[index].isMe ?? false)
                                ? ChatTileA(
                              message: "${state.chats?[index].msg}",
                            )
                                : ChatTileQ(
                              message: "${state.chats?[index].msg}",
                            );
                          }),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: const BoxDecoration(
                              color: Color(0xffF2F4F6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: TextField(
                            cursorColor: Colors.grey,
                            controller: chatController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "ketik pesan  ...",
                              hintStyle: TextStyle(
                                fontSize: 11,
                                color: Color(0xffB1B5BA),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () {
                          context.read<ChatBloc>().add(
                                UpdateConversation(
                                  chat: ChatEntity(
                                    msg: chatController.text,
                                    isMe: false,
                                    time: DateTime.now(),
                                  ),
                                ),
                              );
                          context.read<ChatBloc>().add(
                              SendMessageEvent(payload: chatController.text));
                          chatController.clear();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorPalette.basicRed,
                          ),
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
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

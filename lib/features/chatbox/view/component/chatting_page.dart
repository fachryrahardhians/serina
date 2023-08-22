import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serina/common/color_palette/color_palette.dart';
import 'package:serina/features/chatbox/bloc/chat_bloc/chat_bloc_bloc.dart';
import 'package:serina/features/chatbox/bloc/chat_bloc/chat_bloc_event.dart';
import 'package:serina/features/chatbox/bloc/chat_bloc/chat_bloc_state.dart';
import 'package:serina/features/chatbox/view/component/chatbox_component.dart';
import 'package:serina/features/chatbox/view/component/end_chat_dialog.dart';
import 'package:serina/helper/ui/font_style.dart';

class ChatingPage extends StatefulWidget {
  const ChatingPage({Key? key}) : super(key: key);

  @override
  State<ChatingPage> createState() => _ChatingPageState();
}

class _ChatingPageState extends State<ChatingPage> {
  static TextEditingController chatController = TextEditingController();
  static ScrollController scrollController = ScrollController();
  bool? _textfilled;

  _textfieldListener() {
    setState(() {
      _textfilled = chatController.text.trim().isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    chatController.addListener(_textfieldListener);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        // scrollController.jumpTo(0);
        scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeIn,
        );
      },
      listenWhen: (prev, curr) => prev.chats != curr.chats,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorPalette.backgroudGrey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 5,
            title: Text(
              "SERINA",
              style: bigText.copyWith(
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    showEndChatDialog(context);
                  },
                  child: Text(
                    "Selesai",
                    style: normalText.copyWith(
                      fontWeight: FontWeight.w800,
                      color: ColorPalette.basicRed,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              // Expanded(
              //     child: StreamBuilder(
              //   stream:
              //       FirestoreService(firestore: FirebaseFirestore.instance)
              //           .streamChat(
              //               userId: state.userId??"-",
              //               sessionId: state.sessionId??"-"),
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
              Expanded(
                child: ListView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  shrinkWrap: true,
                  children: List<Widget>.generate(
                        state.chats?.length ?? 0,
                        (index) => Builder(builder: (context) {
                          return ChatTileBuilder(data: state.chats![index]);
                        }),
                      ) +
                      [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              "Today",
                              style: bigText.copyWith(
                                letterSpacing: 0.6,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xffAAACAF),
                              ),
                            ),
                          ),
                        ),
                      ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, -1), // Offset for the drop shadow above
                    ),
                  ],
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
                      onTap: (_textfilled ?? false)
                          ? () {
                              context.read<ChatBloc>().add(SendMessageEvent(
                                  payload: chatController.text));
                              chatController.clear();
                            }
                          : () {},
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (_textfilled ?? false)
                              ? ColorPalette.basicRed
                              : Color(0xffF2F4F6),
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
    );
  }
}

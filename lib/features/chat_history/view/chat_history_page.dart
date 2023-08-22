import 'package:flutter/material.dart';
import 'package:serina/sources/firestore/firestore_service.dart';
import 'package:serina/features/chatbox/view/chatbox_page_builder.dart';
import 'package:serina/sources/firestore/model/firestore_chat_model.dart';
import 'package:serina/common/color_palette/color_palette.dart';

class ChatHistoryPage extends StatefulWidget {
  const ChatHistoryPage({super.key});

  @override
  State<ChatHistoryPage> createState() => _ChatHistoryPageState();
}

class _ChatHistoryPageState extends State<ChatHistoryPage> {
  List<FirestoreSessionModel>? sessions;

  Future<void> getData() async {
    List<FirestoreSessionModel> data =
        await getSessionHistory(userId: "dummyUserId");

    setState(() {
      sessions = data;
    });
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalette.backgroudGrey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 5,
          title: const Text(
            "Riwayat Chat",
            style: TextStyle(
              letterSpacing: 1.2,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        body: ListView(
            children: List<Widget>.generate(
          sessions?.length ?? 0,
          (index) => Column(
            children: [
              index == 0 ||
                      sessions?[index - 1].timestamp !=
                          sessions?[index].timestamp
                  ? Text(sessions?[index].timestamp ?? "-")
                  : const SizedBox(),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ChatboxPage()));
                  },
                  child: Text(sessions?[index].topic ?? "-"))
            ],
          ),
        )));
  }
}

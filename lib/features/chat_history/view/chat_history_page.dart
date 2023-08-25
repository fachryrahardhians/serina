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
  String userId = "4DpgLiu03lzN6WQjy";

  Future<void> getData() async {
    List<FirestoreSessionModel> data = await getSessionHistory(userId: userId);

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            children: List<Widget>.generate(
              sessions?.length ?? 0,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  index == 0 ||
                          sessions?[index - 1].timestamp !=
                              sessions?[index].timestamp
                      ? Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 10),
                          child: Text(sessions?[index].timestamp ?? "-",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)))
                      : const SizedBox(),
                  (Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: TextButton(
                          style: TextButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              minimumSize: Size.fromHeight(50),
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              foregroundColor: Colors.black87),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatboxPage(
                                          userId: userId,
                                          sessionId: sessions?[index].sessionId,
                                        ))).then((value) => getData());
                            ;
                          },
                          child: Text(
                            sessions?[index].topic ?? "-",
                          ))))
                ],
              ),
            )));
  }
}

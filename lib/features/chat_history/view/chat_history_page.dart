import 'package:flutter/material.dart';
import 'package:serina/sources/firestore/firestore_service.dart';
import 'package:serina/features/chatbox/view/chatbox_page.dart';

import 'package:serina/sources/firestore/model/firestore_chat_model.dart';

import 'package:serina/common/color_palette/color_palette.dart';
import 'package:day/day.dart';
import 'package:serina/config/locale.dart';

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

  bool isDateShowing(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) return true;

    return Day.fromDateTime(date1).format("D MMMM YYYY") !=
        Day.fromDateTime(date2).format("D MMMM YYYY");
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
            "Riwayat Chatr",
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
                      isDateShowing(sessions?[index - 1].timestamp,
                          sessions?[index].timestamp)
                  ? Text(sessions?[index].timestamp != null
                      ? Day.fromDateTime(sessions![index].timestamp!)
                          .useLocale(LocaleID)
                          .format("D MMMM YYYY")
                      : "-")
                  : const SizedBox(),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatboxPage()));
                  },
                  child: Text(sessions?[index].topic ?? "-"))
            ],
          ),
        )));
  }
}

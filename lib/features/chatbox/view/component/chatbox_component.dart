import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:serina/features/chatbox/domain/entity/chat_entity.dart';
import 'package:serina/helper/date_formatter/date_formatter.dart';
import 'package:serina/helper/ui/font_style.dart';


class ChatTileQ extends StatelessWidget {
  const ChatTileQ({Key? key, required this.data}) : super(key: key);


  final ChatEntity data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 40,
        right: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
              color: Color(0xffEA001E),
            ),
            child: Text("${data.msg}",style: normalText.copyWith(fontSize: 13,
                color: Colors.white),textAlign: TextAlign.justify,),
          ),
          Text('${data.time?.toStringAMPM()}',style: smallText.copyWith(color:
          const Color(0xff808C92)),),
        ],
      ),
    );
  }
}

class ChatTileA extends StatelessWidget {
  const ChatTileA({Key? key,required this.data}) : super(key: key);

  // final String? message;
  final ChatEntity data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 20,
        right: 40,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Color(0xffE9EBEF),
            ),
            // child: Html(data: data.msg,
            // shrinkWrap: true,
            // ),
            child: Text("${data.msg}",style:  normalText.copyWith(fontSize: 13,
                color: Colors.black),textAlign: TextAlign.justify,),
          ),
          Text('${data.time?.toStringAMPM()}',style: smallText.copyWith
            (color: Color(0xff808C92)),),
        ],
      ),
    );
  }
}


class ChatTileBuilder extends StatelessWidget {
  const ChatTileBuilder({Key? key,  required this.data}) : super(key: key);
  final ChatEntity data;
  @override
  Widget build(BuildContext context) {
    return data.isMe! ? ChatTileQ(data: data,) : ChatTileA(data: data);
  }
}





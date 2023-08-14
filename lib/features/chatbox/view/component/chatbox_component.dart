import 'package:flutter/material.dart';


class ChatTileQ extends StatelessWidget {
  const ChatTileQ({Key? key, this.message}) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
        bottom: 5,
        left: 40,
        right: 20,
      ),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
        color: Color(0xffEA001E),
      ),
      child: Text("$message",style: const TextStyle(fontSize: 12,color: Colors
          .white),),
    );
  }
}

class ChatTileA extends StatelessWidget {
  const ChatTileA({Key? key,this.message}) : super(key: key);

  final String? message;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
        bottom: 5,
        left: 20,
        right: 40,
      ),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(12),
          bottomLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: Color(0xffE9EBEF),
      ),
      child: Text("$message",style: const TextStyle(fontSize: 12,color: Colors
          .black),),
    );
  }
}




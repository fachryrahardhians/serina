import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:convert';

class FirestoreChatModel {
  final String? value;
  final bool? isMe;
  final DateTime? time;

  FirestoreChatModel({
    this.value,
    this.isMe,
    this.time,
  });

  factory FirestoreChatModel.fromRawJson(String str) =>
      FirestoreChatModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FirestoreChatModel.fromJson(Map<String, dynamic> json) =>
      FirestoreChatModel(
        value: json["value"],
        isMe: json["isMe"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "isMe": isMe,
        "time": time?.toIso8601String(),
      };
}

class FirestoreSessionModel {
  final String sessionId;
  final String? topic;
  final DateTime? timestamp;

  FirestoreSessionModel({required this.sessionId, this.topic, this.timestamp});
}



// Map<String,dynamic> chat = {
//   "value" : "bla",
//   "isMe" : false,
//   "time" : "2023-08-10T19:57:00.787988",
// };
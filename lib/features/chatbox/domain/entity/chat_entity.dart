import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  String? msg;
  DateTime? time;
  String? topic;
  bool? isMe;

  ChatEntity({
    this.msg,
    this.time,
    this.topic,
    this.isMe,
  });

  @override
  List<Object?> get props => [
        msg,
        time,
        topic,
        isMe,
      ];
}

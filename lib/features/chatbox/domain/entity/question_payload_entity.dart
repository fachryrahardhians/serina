import 'package:equatable/equatable.dart';

class QuestionPayloadEntity extends Equatable {
  final String? uid;
  final int? k;
  final String? inputQuery;
  final String? lastTopicIssue;

  const QuestionPayloadEntity({
    this.uid,
    this.k,
    this.inputQuery,
    this.lastTopicIssue,
  });

  @override
  List<Object?> get props => [
    uid,
    k,
    inputQuery,
    lastTopicIssue,
  ];
}

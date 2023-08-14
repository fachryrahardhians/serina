// To parse this JSON data, do
//
//     final answerModel = answerModelFromJson(jsonString);

import 'dart:convert';

AnswerModel answerModelFromJson(String str) => AnswerModel.fromJson(json.decode(str));

String answerModelToJson(AnswerModel data) => json.encode(data.toJson());

class AnswerModel {
  String? topicIssue;
  String? query;
  String? answer;

  AnswerModel({
    this.topicIssue,
    this.query,
    this.answer,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
    topicIssue: json["topic_issue"],
    query: json["query"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "topic_issue": topicIssue,
    "query": query,
    "answer": answer,
  };
}

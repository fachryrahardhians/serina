import 'package:dio/dio.dart';
import 'package:serina/sources/api/model/answer_model.dart';

class ChatbotApiService {
  Future<AnswerModel> sendQuestion({
    required String? uid,
    required int? k,
    required String? inputQuery,
    required String? lastTopicIssue,
  }) async {
    try {
      Dio dio = Dio();
      Map<String, dynamic> payload = {
        "uid": "dummy-user-40",
        "k": k,
        "nd": "22222222222",
        "input_query": inputQuery,
        "last_topic_issue": lastTopicIssue
      };
      final result = await dio.request(
        "https://chatbot-faq.mysiis.io/chatbotfaq",
        data: payload,
        options: Options(
          method: "PUT",
          contentType: 'application/json',
        ),
      );

      AnswerModel answer = AnswerModel.fromJson(result.data);
      return answer;
    } catch (e) {
      print("API ERROR $e");
      throw e.toString();
    }
  }
}

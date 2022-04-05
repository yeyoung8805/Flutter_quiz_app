import 'dart:convert';
import 'model_quiz.dart';

List<Quiz> parseQuizs(String  responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //parsed 된 데이터를 퀴즈모델로 변환하여 리스트로 만들면서 parseQuizs 함수를 마무리한다.
  return parsed.map<Quiz>((json) => Quiz.fromJson(json)).toList();
}
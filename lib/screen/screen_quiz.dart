import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/model/model_quiz.dart';

class QuizScreen extends StatefulWidget {
  List<Quiz> quizs;
  QuizScreen({this.quizs}); //생성자를 통해 이전 화면으로부터 퀴즈 데이터를 넘겨받을 수 있다.

  //상태관리 선언
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>{

  //_QuizScreenState는 3가지의 정보 상태를 필요로 한다.
  List<int> _answers = [-1, -1, -1]; //각 퀴즈별 사용자의 정답을 담을 리스트(3문제니까 3개)
  List<bool> _answerState = [false, false, false, false]; //퀴즈하나에 대해 각 선택지가 눌림되었는지 bool 형태로 기록
  int _currentTndex = 0;//현재 어떤 문제를 보고 있는지에 대한 인덱스

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.deepPurple),
            ),
            width: width * 0.85,
            height: height * 0.5,
          ),
        ),
      ),
    );
  }
}
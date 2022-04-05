import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/model/model_quiz.dart';

class ResultScreen extends StatelessWidget {
  List<int> answers;
  List<Quiz> quizs;
  ResultScreen({required this.answers, required this.quizs});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    int score = 0;
    //반복문으로 퀴즈의 정답을 체크하여 score 을 계산한다.
    for(int i=0; i <quizs.length; i++) {
      if(quizs[i].answer == answers[i]) {
        score += 1; //일치하면 점수를 1점 올린다.
      }
    }

    //SafeArea에 Scaffold넣는 방식으로 화면을 구성한다.
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Quiz App'),
          backgroundColor: Colors.deepPurple,
          leading: Container(),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.deepPurple),
              color: Colors.deepPurple
            ),
            width: width * 0.85,
            height: height * 0.5,
            child: Column(
              children: <Widget>[

              ],
            ),
          ),
        ),
      ),
    );
  }
}
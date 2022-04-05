import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/model/model_quiz.dart';
import 'package:flutter_quiz_app/widget/widget_candidate.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class QuizScreen extends StatefulWidget {
  List<Quiz> quizs;

  QuizScreen({required this.quizs}); //생성자를 통해 이전 화면으로부터 퀴즈 데이터를 넘겨받을 수 있다.

  //상태관리 선언
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  //_QuizScreenState는 3가지의 정보 상태를 필요로 한다.
  List<int> _answers = [-1, -1, -1]; //각 퀴즈별 사용자의 정답을 담을 리스트(3문제니까 3개)
  List<bool> _answerState = [
    false,
    false,
    false,
    false
  ]; //퀴즈하나에 대해 각 선택지가 눌림되었는지 bool 형태로 기록
  int _currentTndex = 0; //현재 어떤 문제를 보고 있는지에 대한 인덱스
  SwiperController _controller = SwiperController(); //다음 문제로 넘어가는 것은 Swiper의 controller를 선언해줘야 하며, 여기서 이를 선언한다.

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
            child: Swiper(
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
              loop: false,
              itemCount: widget.quizs.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildQuizCard(widget.quizs[index], width, height);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(Quiz quiz, double width, double height) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
            child: Text(
              'Q' + (_currentTndex + 1).toString() + '.',
              style: TextStyle(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: width * 0.8,
            padding: EdgeInsets.only(top: width * 0.012),
            child: AutoSizeText(
              quiz.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: width * 0.048,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Column(
            children: _buildCandidates(width, quiz),
          ),
          //다음문제로 넘어가는 버튼 만들기
          Container(
            padding: EdgeInsets.all(width * 0.024),
            child: Center(
              child: ButtonTheme(
                minWidth: width * 0.5,
                height: height * 0.05,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RaisedButton(
                  child: _currentTndex == widget.quizs.length - 1
                      ? Text('결과보기')
                      : Text('다음문제'), //현재 인덱스가 마지막 퀴즈를 가리킨다면
                  textColor: Colors.white,
                  color: Colors.deepPurple,
                  onPressed: _answers[_currentTndex] == -1 ? null : () { //-1이라면 정답체크 안됐으므로 null로 설정해 못넘어가도록 함
                    if(_currentTndex == widget.quizs.length -1) { //마지막 퀴즈인지 확인. 마지막이면 결과보기 화면으로 간다.
                      //TODO
                    }else { //마지막 퀴즈가 아니라면 _answerState를 false로 초기화 및 _currentTndex를 증가시킨다.
                      _answerState = [false, false, false, false];
                      _currentTndex += 1;
                      _controller.next();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCandidates(double width, Quiz quiz) {
    List<Widget> _children = [];
    for (int i = 0; i < 4; i++) {
      _children.add(
        CandWidget(
            index: i,
            text: quiz.candidates[i],
            width: width,
            answerState: _answerState[i],
            tap: () {
              setState(() {
                //반복문을 통해 전체 선택지를 확인하며,
                //선택지의 answerState를 true로 변경해주며, answers에 기록한다.
                for (int j = 0; j < 4; j++) {
                  if (j == i) {
                    _answerState[j] = true;
                    _answers[_currentTndex] = j;
                    // print(_answers[_currentTndex]); //log 찍어봄 (선택지의 인덱스 찍어본다.)
                    // print(width);
                  } else {
                    _answerState[j] = false;
                  }
                }
              });
            }),
      ); //children 에 들어갈 각각의 선택지들을 따로 클래스 형태로 만들어서 처리할것임
      _children.add(
        //패딩 추가
        Padding(
          padding: EdgeInsets.all(width * 0.024),
        ),
      );
    }
    return _children;
  }
}

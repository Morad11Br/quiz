import 'package:flutter/material.dart';
import 'package:quiz_app/screens/pics/pics_quiz.dart';
import 'package:quiz_app/screens/pics/pics_result.dart';

class PicturesQuiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PicturesQuizState();
  }
}

class _PicturesQuizState extends State<PicturesQuiz> {
  final _questions = const [
    {
      'picPath': 'assets/random1.jpg',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'white', 'score': 1},
      ],
    },
    {
      'picPath': 'assets/random3.jpg',
      'answers': [
        {'text': 'Rabbit', 'score': 10},
        {'text': 'Snake', 'score': 5},
        {'text': 'Elephant', 'score': 3},
        {'text': 'Lion', 'score': 1},
      ],
    },
    {
      'picPath': 'assets/random4.jpg',
      'answers': [
        {'text': 'Morad', 'score': 10},
        {'text': 'Morad', 'score': 5},
        {'text': 'Morad', 'score': 3},
        {'text': 'Morad', 'score': 1},
      ],
    },
    {
      'picPath': 'assets/random5.jpg',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'white', 'score': 1},
      ],
    },
    {
      'picPath': 'assets/random6.jpg',
      'answers': [
        {'text': 'Rabbit', 'score': 10},
        {'text': 'Snake', 'score': 5},
        {'text': 'Elephant', 'score': 3},
        {'text': 'Lion', 'score': 1},
      ],
    },
    {
      'picPath': 'assets/random7.jpg',
      'answers': [
        {'text': 'Morad', 'score': 10},
        {'text': 'Morad', 'score': 5},
        {'text': 'Morad', 'score': 3},
        {'text': 'Morad', 'score': 1},
      ],
    },
    {
      'picPath': 'assets/random8.jpg',
      'answers': [
        {'text': 'Morad', 'score': 10},
        {'text': 'Morad', 'score': 5},
        {'text': 'Morad', 'score': 3},
        {'text': 'Morad', 'score': 1},
      ],
    },
    {
      'picPath': 'assets/random9.jpg',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'white', 'score': 1},
      ],
    },
    {
      'picPath': 'assets/random10.jpg',
      'answers': [
        {'text': 'Rabbit', 'score': 10},
        {'text': 'Snake', 'score': 5},
        {'text': 'Elephant', 'score': 3},
        {'text': 'Lion', 'score': 1},
      ],
    },
    {
      'picPath': 'assets/random11.jpg',
      'answers': [
        {'text': 'Morad', 'score': 10},
        {'text': 'Morad', 'score': 5},
        {'text': 'Morad', 'score': 3},
        {'text': 'Morad', 'score': 1},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    //_totalScore = _totalScore + score;
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: _questionIndex < _questions.length
          ? PicsQuiz(
              answerQuestion: _answerQuestion,
              questionIndex: _questionIndex,
              questions: _questions,
            )
          : PicsResult(_totalScore, _resetQuiz),
    );
  }
}

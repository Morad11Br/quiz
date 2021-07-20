import 'package:flutter/material.dart';
import 'package:quiz_app/screens/voice/voice_quiz.dart';
import 'package:quiz_app/screens/voice/voice_result.dart';

class MainVoiceQuiz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainVoiceQuizState();
  }
}

class _MainVoiceQuizState extends State<MainVoiceQuiz> {
  final _questions = const [
    {
      'voicePath': 'audio1.mp3',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'white', 'score': 1},
      ],
    },
    {
      'voicePath': 'audio2.mp3',
      'answers': [
        {'text': 'Rabbit', 'score': 10},
        {'text': 'Snake', 'score': 5},
        {'text': 'Elephant', 'score': 3},
        {'text': 'Lion', 'score': 1},
      ],
    },
    {
      'voicePath': 'audio3.mp3',
      'answers': [
        {'text': 'Morad', 'score': 10},
        {'text': 'Morad', 'score': 5},
        {'text': 'Morad', 'score': 3},
        {'text': 'Morad', 'score': 1},
      ],
    },
    {
      'voicePath': 'audio4.mp3',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'white', 'score': 1},
      ],
    },
    {
      'voicePath': 'audio5.mp3',
      'answers': [
        {'text': 'Rabbit', 'score': 10},
        {'text': 'Snake', 'score': 5},
        {'text': 'Elephant', 'score': 3},
        {'text': 'Lion', 'score': 1},
      ],
    },
    {
      'voicePath': 'audio6.mp3',
      'answers': [
        {'text': 'Morad', 'score': 10},
        {'text': 'Morad', 'score': 5},
        {'text': 'Morad', 'score': 3},
        {'text': 'Morad', 'score': 1},
      ],
    },
    {
      'voicePath': 'audio7.mp3',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'white', 'score': 1},
      ],
    },
    {
      'voicePath': 'audio8.mp3',
      'answers': [
        {'text': 'Rabbit', 'score': 10},
        {'text': 'Snake', 'score': 5},
        {'text': 'Elephant', 'score': 3},
        {'text': 'Lion', 'score': 1},
      ],
    },
    {
      'voicePath': 'audio9.mp3',
      'answers': [
        {'text': 'Morad', 'score': 10},
        {'text': 'Morad', 'score': 5},
        {'text': 'Morad', 'score': 3},
        {'text': 'Morad', 'score': 1},
      ],
    },
    {
      'voicePath': 'audio10.mp3',
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
          ? VoiceQuiz(
              answerQuestion: _answerQuestion,
              questionIndex: _questionIndex,
              questions: _questions,
            )
          : VoiceResult(_totalScore, _resetQuiz),
    );
  }
}

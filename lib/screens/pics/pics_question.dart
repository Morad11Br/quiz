import 'package:flutter/material.dart';

class PicsQuestion extends StatelessWidget {
  final String questionPics;

  PicsQuestion(this.questionPics);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      margin: EdgeInsets.all(10),
      child: Image.asset(
        questionPics,
        fit: BoxFit.cover,
      ),
    );
  }
}

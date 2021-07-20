import 'package:flutter/material.dart';

class VoiceAnswer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;

  VoiceAnswer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selectHandler,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: Center(child: Text(answerText)),
      ),
    );
  }
}

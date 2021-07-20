import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/voice/voice_answer.dart';
import 'package:quiz_app/screens/voice/voice_question.dart';

import '../../ads_manager.dart';

class VoiceQuiz extends StatefulWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  VoiceQuiz({
    @required this.questions,
    @required this.answerQuestion,
    @required this.questionIndex,
  });

  @override
  _VoiceQuizState createState() => _VoiceQuizState();
}

class _VoiceQuizState extends State<VoiceQuiz> {
  bool isAppodealInitialized = false;

  @override
  void initState() {
    super.initState();

    // Set the app keys
    Appodeal.setAppKeys(
      androidAppKey: AdsManager().appKey,
    );

    // Defining the callbacks
    Appodeal.setBannerCallback(
        (event) => print('Banner ad triggered the event $event'));
    Appodeal.setInterstitialCallback(
        (event) => print('Interstitial ad triggered the event $event'));

    // Request authorization to track the user
    Appodeal.requestIOSTrackingAuthorization().then((_) async {
      // Set interstitial ads to be cached manually
      await Appodeal.setAutoCache(AdType.INTERSTITIAL, false);

      // Initialize Appodeal after the authorization was granted or not
      await Appodeal.initialize(
        hasConsent: true,
        adTypes: [AdType.BANNER, AdType.INTERSTITIAL],
        testMode: AdsManager().testingAds,
      );

      setState(() => this.isAppodealInitialized = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "whose Voice is that?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            VoiceQuestion(
              widget.questions[widget.questionIndex]['voicePath'],
            ),
            ...(widget.questions[widget.questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map((answer) {
              return VoiceAnswer(
                  () => widget.answerQuestion(answer['score']), answer['text']);
            }).toList(),
            Container(
              // color: Colors.amber,
              height: 80,
              child: AppodealBanner(
                placementName: "placement-name",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

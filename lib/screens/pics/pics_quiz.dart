import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screens/pics/pics_answer.dart';
import 'package:quiz_app/screens/pics/pics_question.dart';

import '../../ads_manager.dart';

class PicsQuiz extends StatefulWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  PicsQuiz({
    @required this.questions,
    @required this.answerQuestion,
    @required this.questionIndex,
  });

  @override
  _PicsQuizState createState() => _PicsQuizState();
}

class _PicsQuizState extends State<PicsQuiz> {
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "whose picture is this?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              PicsQuestion(
                widget.questions[widget.questionIndex]['picPath'],
              ),
              ...(widget.questions[widget.questionIndex]['answers']
                      as List<Map<String, Object>>)
                  .map((answer) {
                return PicsAnswer(() => widget.answerQuestion(answer['score']),
                    answer['text']);
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
      ),
    );
  }
}

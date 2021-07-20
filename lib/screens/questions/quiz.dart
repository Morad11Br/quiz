import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:flutter/material.dart';
import '../../ads_manager.dart';
import './question.dart';
import './answer.dart';

class Quiz extends StatefulWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    @required this.questions,
    @required this.answerQuestion,
    @required this.questionIndex,
  });

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Question(
          widget.questions[widget.questionIndex]['questionText'],
        ),
        ...(widget.questions[widget.questionIndex]['answers']
                as List<Map<String, Object>>)
            .map((answer) {
          return Answer(
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
    );
  }
}

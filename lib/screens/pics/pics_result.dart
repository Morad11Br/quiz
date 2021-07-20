import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/ads_manager.dart';

class PicsResult extends StatefulWidget {
  final int resultScore;
  final Function resetHandler;

  PicsResult(this.resultScore, this.resetHandler);

  @override
  _PicsResultState createState() => _PicsResultState();
}

class _PicsResultState extends State<PicsResult> {
  String get resultPhrase {
    String resultText;
    if (widget.resultScore <= 8) {
      resultText = 'assets/good-job.jpg';
    } else if (widget.resultScore <= 12) {
      resultText = 'assets/great.jpg';
    } else if (widget.resultScore <= 16) {
      resultText = 'assets/excellent.png';
    } else {
      resultText = 'assets/bad.jpg';
    }
    return resultText;
  }

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
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: Image(
              image: AssetImage(
                resultPhrase,
              ),
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: 20,
            child: Text(
              'Your Score Is ${widget.resultScore}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: ElevatedButton(
              child: Text(
                'Restart Quiz',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.blue),
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              // textColor: Colors.blue,
              onPressed: () async {
                await Appodeal.cache(AdType.INTERSTITIAL);
                Appodeal.show(AdType.INTERSTITIAL,
                    placementName: "placement-name");
                widget.resetHandler();
              },
            ),
          ),
        ],
      ),
    );
  }
}

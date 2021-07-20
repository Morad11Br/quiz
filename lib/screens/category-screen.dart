import 'package:appodeal_flutter/appodeal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/ads_manager.dart';
import 'package:quiz_app/screens/pics/main_pictures_quiz.dart';
import 'package:quiz_app/screens/questions/main_question_quiz.dart';
import 'package:quiz_app/screens/voice/main_voice_quiz.dart';
import 'package:url_launcher/url_launcher.dart';

const _url = 'https://flutter.dev';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Category',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 1,
            width: double.infinity,
            child: Image.asset(
              "assets/back_ground.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await Appodeal.cache(AdType.INTERSTITIAL);
                    Appodeal.show(AdType.INTERSTITIAL,
                        placementName: "placement-name");

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuestionsQuiz(),
                      ),
                    );
                  },
                  child: categoryButtons(context, "Questions"),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    await Appodeal.cache(AdType.INTERSTITIAL);
                    Appodeal.show(AdType.INTERSTITIAL,
                        placementName: "placement-name");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainVoiceQuiz(),
                      ),
                    );
                  },
                  child: categoryButtons(context, "Guess Who By Voice?"),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    await Appodeal.cache(AdType.INTERSTITIAL);
                    Appodeal.show(AdType.INTERSTITIAL,
                        placementName: "placement-name");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PicturesQuiz(),
                      ),
                    );
                  },
                  child: categoryButtons(context, "Guess Who?"),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: _launchURL,
                  child: categoryButtons(context, "More Apps!"),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 20,
            child: Container(
              // color: Colors.amber,
              height: 80,
              child: AppodealBanner(
                placementName: "placement-name",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container categoryButtons(BuildContext context, String title) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

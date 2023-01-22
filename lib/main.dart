import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'patanllaOpcionAnuncio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final RewardedAd rewardedAd;
  final String rewardedAdUnitId = "ca-app-pub-3940256099942544/5224354917";

  @override
  void initialize(){
    super.initState();
    // load ad here...
    _loadRewardedAd();
  }

  // method to load an ad
  _loadRewardedAd(){
    RewardedAd.load(
      adUnitId: rewardedAdUnitId, 
      request: const AdRequest(), 
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad){
          // keep a reference to the ad so you can show it later.
          rewardedAd = ad;

          // set on full screen content call back
          _setFullScreenContentCallback();

        }, 
        onAdFailedToLoad: (LoadAdError error){
          print('Failed to load rewarded ad, Error: $error');
        }
      )      
    );
  }

  // method to set show content call back
  void _setFullScreenContentCallback(){
    // ignore: unnecessary_null_comparison
    if (rewardedAd == null) {return;}
    rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      // when ad shows by user
      onAdShowedFullScreenContent: (RewardedAd ad) {
        print("$ad onAdShowedFullScreenContent");
      },
      // when ad dismised by user
      onAdDismissedFullScreenContent: (RewardedAd ad){
        print("$ad onAdDismissedFullScreenContent");

        // dispose the dismissed ad
        ad.dispose();        
      },
      // When ad fails to show
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error){
        print("$ad onAdFailedToShowFullScreenContent: $error ");
        ad.dispose;
      },
      onAdImpression: (RewardedAd ad){
        print("$ad Impression occurred ");
      }
    );
  }

  // show ad method
  void _ShowRewardedAd(){
    // this method take a on user earned reward call back
    rewardedAd.show(
      onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem){
        // reward user for watching your ad
        num amount = rewardItem.amount;
        print("You earned: $amount");
      }
      
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
     
        title: Text(widget.title),
      ),
      body: Center(
       child: InkWell(
        onTap: _ShowRewardedAd,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          height: 100,
          color: Colors.orange,
          child: const Text(
            "Show Rewarded Ad",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 35
            )
          ),
        ),
       ),
     
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: _incrementCounter,
        onPressed: () {          
          Navigator.push(context,
            // MaterialPageRoute(builder: (context) => AnuncioScreen() )
            MaterialPageRoute(builder: (context) =>   patallaAnuncio(title: 'title',) )
          );
        },
       
        
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

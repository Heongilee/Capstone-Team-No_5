import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

// void main(){
//   runApp(MaterialApp(
//     home: HomeScreen(),
//   ));
// }
class Example extends StatelessWidget{
  Widget build(BuildContext context){

    String appId = "ca-app-pub-9179900992913670~4602448319";
    FirebaseAdMob.instance.initialize(appId: appId);

    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  childDirected: false,// or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: BannerAd.testAdUnitId,
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

myBanner
  // typically this happens well before the ad is shown
  ..load()
  ..show(
    // Positions the banner ad 60 pixels from the bottom of the screen
    anchorOffset: 0.0,
    // Positions the banner ad 10 pixels from the center of the screen to the right
    horizontalCenterOffset: 10.0,
    // Banner Position
    anchorType: AnchorType.bottom,
  );

    return Scaffold(
      appBar: AppBar(
        title: Text('Exam'),
      ),
      body: Center(child: Text('AdMob')),
    );
  }
}
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_admob/firebase_admob.dart';
import './counter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'I2020OY?',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Flutter'),
        '/counter': (context) => CounterPage(title: 'Counter')
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _year = new DateTime.now().year == 2020 ? 'No' : 'Yes';
  BannerAd _bannerAd;

  Timer timer;
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: null,
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  void _goToCounter() {
    Navigator.pushNamed(context, '/counter');
  }

  void _checkYear() {
    String year = new DateTime.now().year == 2020 ? 'No' : 'Yes';
    if (year != _year)
      setState(() {
        _year = year;
      });
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (t) => _checkYear());
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  @override
  void dispose() {
    timer?.cancel();
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Theme.of(context).brightness,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Is 2020 over yet?',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              '$_year',
              style: Theme.of(context).textTheme.headline1,
            ),
            Opacity(
              opacity: _year == "No" ? 1.0 : 0.0,
              child: OutlineButton(
                  color: Colors.transparent,
                  onPressed: _year == "No" ? _goToCounter : null,
                  child: Text(
                    'When will it be over ?',
                    style: Theme.of(context).textTheme.bodyText2,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

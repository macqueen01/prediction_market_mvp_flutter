import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:perdiction_market_mvp/MainPage.dart';
import 'package:perdiction_market_mvp/OrderPages/OrderPage.dart';
import 'package:perdiction_market_mvp/OrderPages/SellOrderPage.dart';
import 'package:perdiction_market_mvp/PredictionMarketDetailPage.dart';
import 'package:perdiction_market_mvp/UserProfile.dart';
import 'package:perdiction_market_mvp/WithdrawPages/WriteBankAccountPage.dart';

void main() {
  /*
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  */
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deja',
      initialRoute: '/',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => MainPage(),
        '/user-profile': (context) => const UserProfilePage(),
        '/withdraw': (context) => const WriteBankAccountPage(),
        '/prediction-market': (context) => PredictionMarketPage(),
        '/dummy-buy-order-page': (context) => DummyBuyOrderPageTestRoute(),
        '/dummy-sell-order-page': (context) => DummySellOrderPageTestRoute(),
      },
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

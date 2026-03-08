import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'config/firebase_config.dart';
import 'config/remote_config.dart';
import 'core/admob/app_open_ad_manager.dart';
import 'core/admob/interstitial_ad_manager.dart';
import 'core/admob/rewarded_ad_manager.dart';
import 'core/analytics/analytics_service.dart';
import 'core/consent/consent_manager.dart';

final appOpenAdManager = AppOpenAdManager();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Firebase 초기화 (Analytics, Crashlytics)
  await FirebaseConfig.init();
  // 2. Remote Config 값 로드
  await RemoteConfigService.init();
  // 3. GDPR 동의 요청
  await ConsentManager.requestConsent();
  // 4. AdMob 초기화 + 광고 미리 로드
  await MobileAds.instance.initialize();
  InterstitialAdManager.load();
  RewardedAdManager.load();
  appOpenAdManager.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apps Template',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      navigatorObservers: [AnalyticsService.observer],
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Apps Template'),
      ),
      body: const Center(
        child: Text('Template Ready'),
      ),
    );
  }
}

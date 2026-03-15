import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/firebase_config.dart';
import 'config/remote_config.dart';
import 'core/admob/ad_service.dart';
import 'core/analytics_service.dart';
import 'core/review_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Firebase 초기화 (Analytics, Crashlytics)
  await FirebaseConfig.init();
  // 2. Remote Config 값 로드
  await RemoteConfigService.init();
  // 3. AdMob 초기화 (GDPR 동의 → SDK 초기화 → 광고 프리로드)
  await AdService.init();
  // 4. 리뷰 요청 (실행 횟수 기반)
  ReviewService.requestIfReady();

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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
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

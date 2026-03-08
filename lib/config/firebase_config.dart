import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseConfig {
  static Future<void> init() async {
    await Firebase.initializeApp();
    _setupCrashlytics();
  }

  static void _setupCrashlytics() {
    // Flutter 프레임워크 에러 → Crashlytics로 전송
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // 비동기 에러 (Flutter 프레임워크 밖) → Crashlytics로 전송
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
}

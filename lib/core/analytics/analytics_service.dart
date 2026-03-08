import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final instance = FirebaseAnalytics.instance;
  static final observer = FirebaseAnalyticsObserver(analytics: instance);

  /// 화면 전환 로깅
  static Future<void> logScreenView(String screenName) {
    return instance.logScreenView(screenName: screenName);
  }

  /// 커스텀 이벤트 로깅
  static Future<void> logEvent(
    String name, {
    Map<String, Object>? parameters,
  }) {
    return instance.logEvent(name: name, parameters: parameters);
  }
}

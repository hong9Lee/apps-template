import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app_open_ad_manager.dart';
import 'consent_manager.dart';
import 'interstitial_ad_manager.dart';
import 'rewarded_ad_manager.dart';

class AdService {
  static AppOpenAdManager? _appOpenAdManager;

  static AppOpenAdManager get appOpenAdManager {
    _appOpenAdManager ??= AppOpenAdManager();
    return _appOpenAdManager!;
  }

  /// AdMob 전체 초기화: 동의 → SDK 초기화 → 광고 프리로드
  static Future<void> init() async {
    await ConsentManager.requestConsent();
    await MobileAds.instance.initialize();

    if (await ConsentManager.canRequestAds()) {
      InterstitialAdManager.load();
      RewardedAdManager.load();
      appOpenAdManager.init();
    }
  }
}

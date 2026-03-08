import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../config/ad_config.dart';
import '../../config/remote_config.dart';

class InterstitialAdManager {
  static InterstitialAd? _ad;
  static int _actionCount = 0;

  /// 사용자 액션마다 호출. interval에 도달하면 광고 표시.
  static void onAction() {
    _actionCount++;
    if (_actionCount >= RemoteConfigService.interstitialInterval) {
      _actionCount = 0;
      show();
    }
  }

  static void load() {
    InterstitialAd.load(
      adUnitId: AdConfig.interstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _ad = ad,
        onAdFailedToLoad: (_) => _ad = null,
      ),
    );
  }

  static void show() {
    if (_ad == null) {
      load();
      return;
    }
    _ad!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _ad = null;
        load();
      },
      onAdFailedToShowFullScreenContent: (ad, _) {
        ad.dispose();
        _ad = null;
        load();
      },
    );
    _ad!.show();
  }
}

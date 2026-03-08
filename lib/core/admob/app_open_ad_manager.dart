import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../config/ad_config.dart';
import '../../config/remote_config.dart';

class AppOpenAdManager with WidgetsBindingObserver {
  AppOpenAd? _ad;
  bool _isShowingAd = false;
  DateTime? _lastAdTime;

  void init() {
    WidgetsBinding.instance.addObserver(this);
    _loadAd();
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _ad?.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _showAdIfAvailable();
    }
  }

  void _loadAd() {
    if (!RemoteConfigService.enableAppOpenAd) return;

    AppOpenAd.load(
      adUnitId: AdConfig.appOpenId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) => _ad = ad,
        onAdFailedToLoad: (_) => _ad = null,
      ),
    );
  }

  void _showAdIfAvailable() {
    if (!RemoteConfigService.enableAppOpenAd) return;
    if (_isShowingAd) return;
    if (_ad == null) {
      _loadAd();
      return;
    }

    // 마지막 광고로부터 4시간 이내면 스킵
    if (_lastAdTime != null &&
        DateTime.now().difference(_lastAdTime!) < const Duration(hours: 4)) {
      return;
    }

    _ad!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) => _isShowingAd = true,
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        _lastAdTime = DateTime.now();
        ad.dispose();
        _ad = null;
        _loadAd();
      },
      onAdFailedToShowFullScreenContent: (ad, _) {
        _isShowingAd = false;
        ad.dispose();
        _ad = null;
        _loadAd();
      },
    );
    _ad!.show();
  }
}

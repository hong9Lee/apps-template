import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../config/ad_config.dart';
import 'ad_reward.dart';

class RewardedAdManager {
  static RewardedAd? _ad;

  static void load() {
    RewardedAd.load(
      adUnitId: AdConfig.rewardedId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _ad = ad,
        onAdFailedToLoad: (_) => _ad = null,
      ),
    );
  }

  /// 리워드 광고 표시. 보상 콜백을 전달받는다.
  static void show({required void Function(AdReward reward) onRewarded}) {
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
    _ad!.show(
      onUserEarnedReward: (_, reward) => onRewarded(
        AdReward(amount: reward.amount.toInt(), type: reward.type),
      ),
    );
  }
}

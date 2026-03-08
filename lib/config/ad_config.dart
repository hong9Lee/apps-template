import 'flavor_config.dart';

class AdConfig {
  // Google 공식 테스트 광고 ID (dev용)
  static const _testBanner = 'ca-app-pub-3940256099942544/6300978111';
  static const _testInterstitial = 'ca-app-pub-3940256099942544/1033173712';
  static const _testRewarded = 'ca-app-pub-3940256099942544/5224354917';
  static const _testAppOpen = 'ca-app-pub-3940256099942544/9257395921';

  // TODO: clone 후 실제 광고 유닛 ID로 교체
  static const _prodBanner = 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';
  static const _prodInterstitial = 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';
  static const _prodRewarded = 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';
  static const _prodAppOpen = 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX';

  static String get bannerId =>
      FlavorConfig.isDev ? _testBanner : _prodBanner;

  static String get interstitialId =>
      FlavorConfig.isDev ? _testInterstitial : _prodInterstitial;

  static String get rewardedId =>
      FlavorConfig.isDev ? _testRewarded : _prodRewarded;

  static String get appOpenId =>
      FlavorConfig.isDev ? _testAppOpen : _prodAppOpen;
}

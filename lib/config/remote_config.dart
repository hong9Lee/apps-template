import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static final _rc = FirebaseRemoteConfig.instance;

  static final _defaults = <String, dynamic>{
    'minimum_version': '1.0.0',
    'interstitial_interval': 3,
    'enable_app_open_ad': true,
    'enable_rewarded_ad': true,
    'enable_banner_ad': true,
    'review_prompt_count': 5,
  };

  static Future<void> init() async {
    await _rc.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await _rc.setDefaults(_defaults);
    await _rc.fetchAndActivate();
  }

  // --- Getters ---

  static String get minimumVersion => _rc.getString('minimum_version');
  static int get interstitialInterval => _rc.getInt('interstitial_interval');
  static bool get enableAppOpenAd => _rc.getBool('enable_app_open_ad');
  static bool get enableRewardedAd => _rc.getBool('enable_rewarded_ad');
  static bool get enableBannerAd => _rc.getBool('enable_banner_ad');
  static int get reviewPromptCount => _rc.getInt('review_prompt_count');
}

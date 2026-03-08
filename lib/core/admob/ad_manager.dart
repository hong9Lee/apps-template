import '../consent/consent_manager.dart';
import '../network/network_checker.dart';

/// 모든 광고 로드 전에 호출. 동의 + 네트워크 둘 다 통과해야 광고 로드 가능.
class AdGuard {
  static Future<bool> canLoadAd() async {
    final hasNetwork = await NetworkChecker.hasConnection();
    if (!hasNetwork) return false;
    return await ConsentManager.canRequestAds();
  }
}

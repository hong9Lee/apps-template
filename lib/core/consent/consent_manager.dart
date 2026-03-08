import 'package:google_mobile_ads/google_mobile_ads.dart';

class ConsentManager {
  /// UMP 동의 폼을 요청하고 필요 시 표시한다.
  /// AdMob 광고 로드 전에 반드시 호출해야 한다.
  static Future<void> requestConsent() async {
    final params = ConsentRequestParameters();

    ConsentInformation.instance.requestConsentInfoUpdate(
      params,
      () async {
        if (await ConsentInformation.instance.isConsentFormAvailable()) {
          _showConsentForm();
        }
      },
      (error) {
        // 동의 정보 업데이트 실패 — 광고는 그대로 로드 (비EEA 지역)
      },
    );
  }

  static void _showConsentForm() {
    ConsentForm.loadConsentForm(
      (form) => form.show((error) {}),
      (error) {},
    );
  }

  /// 광고를 로드해도 되는 상태인지 확인
  static Future<bool> canRequestAds() async {
    return await ConsentInformation.instance.canRequestAds();
  }
}

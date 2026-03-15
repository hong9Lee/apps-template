import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class ConsentManager {
  /// UMP 동의 폼을 요청하고, 완료될 때까지 기다린다.
  /// AdMob 광고 로드 전에 반드시 호출해야 한다.
  static Future<void> requestConsent() async {
    final completer = Completer<void>();
    final params = ConsentRequestParameters();

    ConsentInformation.instance.requestConsentInfoUpdate(
      params,
      () async {
        if (await ConsentInformation.instance.isConsentFormAvailable()) {
          await _showConsentForm();
        }
        completer.complete();
      },
      (error) {
        // 동의 정보 업데이트 실패 — 비EEA 지역이거나 네트워크 에러
        completer.complete();
      },
    );

    return completer.future;
  }

  static Future<void> _showConsentForm() {
    final completer = Completer<void>();
    ConsentForm.loadConsentForm(
      (form) => form.show((error) => completer.complete()),
      (error) => completer.complete(),
    );
    return completer.future;
  }

  /// 광고를 로드해도 되는 상태인지 확인
  static Future<bool> canRequestAds() async {
    return await ConsentInformation.instance.canRequestAds();
  }
}

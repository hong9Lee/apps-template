import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/remote_config.dart';

class ReviewService {
  static const _key = 'app_open_count';

  /// 앱 실행 시 호출. 실행 횟수가 Remote Config의 review_prompt_count에 도달하면 리뷰 요청.
  static Future<void> requestIfReady() async {
    final prefs = await SharedPreferences.getInstance();
    final count = (prefs.getInt(_key) ?? 0) + 1;
    await prefs.setInt(_key, count);

    if (count == RemoteConfigService.reviewPromptCount) {
      final reviewer = InAppReview.instance;
      if (await reviewer.isAvailable()) {
        await reviewer.requestReview();
      }
    }
  }
}

import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/remote_config.dart';

class ReviewService {
  static const _countKey = 'app_open_count';
  static const _reviewedKey = 'review_requested';

  /// 앱 실행 시 호출. 실행 횟수가 Remote Config의 review_prompt_count 이상이면 리뷰 요청.
  /// 한번 요청하면 다시 요청하지 않음.
  static Future<void> requestIfReady() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_reviewedKey) ?? false) return;

    final count = (prefs.getInt(_countKey) ?? 0) + 1;
    await prefs.setInt(_countKey, count);

    if (count >= RemoteConfigService.reviewPromptCount) {
      final reviewer = InAppReview.instance;
      if (await reviewer.isAvailable()) {
        await reviewer.requestReview();
        await prefs.setBool(_reviewedKey, true);
      }
    }
  }
}

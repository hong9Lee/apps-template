import 'package:flutter/material.dart';

import '../../config/remote_config.dart';

class ForceUpdate {
  /// 현재 앱 버전이 Remote Config의 minimum_version보다 낮으면 강제 업데이트 다이얼로그 표시.
  /// main 화면 진입 후 호출.
  static void checkAndShow(BuildContext context, String currentVersion) {
    final minimum = RemoteConfigService.minimumVersion;
    if (_isOlderThan(currentVersion, minimum)) {
      _showUpdateDialog(context);
    }
  }

  /// 버전 비교: current < minimum 이면 true
  static bool _isOlderThan(String current, String minimum) {
    final cur = current.split('.').map(int.tryParse).toList();
    final min = minimum.split('.').map(int.tryParse).toList();

    for (var i = 0; i < 3; i++) {
      final c = (i < cur.length ? cur[i] : 0) ?? 0;
      final m = (i < min.length ? min[i] : 0) ?? 0;
      if (c < m) return true;
      if (c > m) return false;
    }
    return false;
  }

  static void _showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('업데이트 필요'),
          content: const Text('새로운 버전이 출시되었습니다.\n앱을 업데이트해주세요.'),
          actions: [
            TextButton(
              onPressed: () {
                // TODO: Play Store URL로 이동
                // launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=YOUR_APP_ID'));
              },
              child: const Text('업데이트'),
            ),
          ],
        ),
      ),
    );
  }
}

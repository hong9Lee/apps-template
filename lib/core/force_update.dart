import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/remote_config.dart';

class ForceUpdate {
  /// 현재 앱 버전이 Remote Config의 minimum_version보다 낮으면 강제 업데이트 다이얼로그 표시.
  /// main 화면 진입 후 호출.
  static void checkAndShow(
    BuildContext context, {
    required String currentVersion,
    required String packageName,
  }) {
    final minimum = RemoteConfigService.minimumVersion;
    if (_isOlderThan(currentVersion, minimum)) {
      _showUpdateDialog(context, packageName);
    }
  }

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

  static void _showUpdateDialog(BuildContext context, String packageName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Update Required'),
          content: const Text('A new version is available.\nPlease update the app.'),
          actions: [
            TextButton(
              onPressed: () {
                launchUrl(
                  Uri.parse('https://play.google.com/store/apps/details?id=$packageName'),
                  mode: LaunchMode.externalApplication,
                );
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkChecker {
  static Future<bool> hasConnection() async {
    final results = await Connectivity().checkConnectivity();
    return results.any((r) => r != ConnectivityResult.none);
  }
}

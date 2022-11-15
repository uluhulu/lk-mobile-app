import 'dart:io';

import 'package:fk_user_agent/fk_user_agent.dart';

/// Инфо устройства
class DeviceInfo {
  factory DeviceInfo() => _instance ?? DeviceInfo._internal();

  DeviceInfo._internal();

  static DeviceInfo? _instance;

  static Future<DeviceInfo> initialize() async {
    if (_instance == null) {
      if (Platform.isAndroid || Platform.isIOS) {
        await FkUserAgent.init();
      }
    }

    return _instance ??= DeviceInfo._internal();
  }

  String get applicationFullName {
    if (Platform.isAndroid || Platform.isIOS) {
      return <String?>[
        FkUserAgent.getProperty('applicationName') as String?,
        FkUserAgent.getProperty('systemName') as String?,
        FkUserAgent.getProperty('applicationVersion') as String?,
      ].where((String? element) => element != null).toList().join(' ');
    } else {
      return 'Desktop';
    }
  }

  String get userAgent {
    if (Platform.isAndroid || Platform.isIOS) {
      return FkUserAgent.webViewUserAgent ?? '';
    } else {
      return 'Mozilla/5.0 (Linux; Android 4.0.4; Galaxy Nexus Build/IMM76B)';
    }
  }
}

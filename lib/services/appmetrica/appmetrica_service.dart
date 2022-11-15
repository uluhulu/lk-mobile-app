import 'dart:async';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:injectable/injectable.dart';
import '../../locator/locator.dart';
import '../platform.dart';

import '../env/env.dart';

@lazySingleton
class AppMetricaService {
  late Env env = sl<Env>();
  AppMetricaService();
  late String appKey = env.appMetricaKey;

  FutureOr<void> initialize() async {
    if (isMobile()) {
      await AppMetrica.activate(AppMetricaConfig(appKey));
    }
  }

  Future<void> onCrash(Object error, {StackTrace? stackTrace}) async {
    if (isMobile()) {
      final errorDescription =
          stackTrace == null ? null : AppMetricaErrorDescription(stackTrace);
      await AppMetrica.reportErrorWithGroup('crash',
          errorDescription: errorDescription, message: error.toString());
    }
  }
}

import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';

import '../../../services/platform.dart';
import '../utils/resources/exception.dart';

///  Аналитика
class AnalyticsClient {
  factory AnalyticsClient() => _instance ?? AnalyticsClient._internal();

  AnalyticsClient._internal();

  static AnalyticsClient? _instance;
  static FirebaseAnalytics? _analytics;
  static FirebaseCrashlytics? _crashlytics;
  static bool supported = false;
  static Future<AnalyticsClient> initialize() async {
    if (_instance == null) {
      if (isMobile() && supported) {
        _analytics = FirebaseAnalytics.instance;
        _crashlytics = FirebaseCrashlytics.instance;
      }
    }

    return _instance ??= AnalyticsClient._internal();
  }

  Future<void> setAnalyticsState({
    bool enabled = true,
  }) async {
    _analytics?.setAnalyticsCollectionEnabled(enabled);
    _crashlytics?.setCrashlyticsCollectionEnabled(enabled);
  }

  Future<void> recordError(
    dynamic exception,
    StackTrace? stack, {
    bool fatal = false,
  }) async {
    if (exception is DioError) {
      if (exception.error is HttpInternetException) return;

      Logger().d(exception.toString());
      Logger().d(exception.requestOptions.uri.toString());
      await _crashlytics?.log(exception.toString());
      await _crashlytics?.log(exception.requestOptions.uri.toString());
      await _crashlytics
          ?.log("DioError error type: ${exception.error.runtimeType}");

      if (exception.type == DioErrorType.response &&
          exception.response != null) {
        Logger().d(exception.response.toString());
        Logger().d(exception.response!.statusCode.toString());
        await _crashlytics?.log(exception.response.toString());
        await _crashlytics?.log(exception.response!.statusCode.toString());
      }
    } else {
      await _crashlytics?.log("Exception type: ${exception.runtimeType}");
    }

    return _crashlytics?.recordError(
      exception,
      stack,
      fatal: fatal,
    );
  }

  Future<void> setUserId(int id) async {
    Future.wait(<Future<void>>[
      _crashlytics?.setUserIdentifier(id.toString()) ??
          Future.delayed(Duration.zero),
      _analytics?.setUserId(id: id.toString()) ?? Future.delayed(Duration.zero),
    ]);
  }

  Future<void> setLoginMethod(String loginMethod) async {
    await _analytics?.logLogin(
      loginMethod: loginMethod,
    );
  }

  static Future<void> log(String log) async {
    if (isMobile() && supported) {
      await AnalyticsClient.log(log);
    }
  }
}

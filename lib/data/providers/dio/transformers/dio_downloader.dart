import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/native_imp.dart';

import 'interceptors/dio_error_interceptor.dart';

/// Клиент скачивания файлов
class DioDownloader extends DioForNative {
  factory DioDownloader() => _instance ?? DioDownloader._internal();

  DioDownloader._internal() {
    interceptors.add(DioErrorInterceptor());
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    _instance = this;
  }

  static DioDownloader? _instance;
}

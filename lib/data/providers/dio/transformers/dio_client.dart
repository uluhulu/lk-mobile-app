import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/material.dart';

import 'interceptors/dio_auth_interceptor.dart';
import 'interceptors/dio_error_interceptor.dart';
import 'interceptors/dio_user_agent_interceptor.dart';

/// Клиент запросов
class DioClient extends DioForNative {
  factory DioClient() => _instance ?? DioClient._internal();
  static String currentToken = '';
  DioClient._internal() {
    interceptors.addAll([
      DioErrorInterceptor(),
    ]);

    options = BaseOptions();
    _instance = this;
  }

  static DioClient? _instance;

  static DioClient initialize({
    required String baseUrl,
    required String userAgent,
  }) {
    final uri = Uri.http(baseUrl, '/');
    DioClient().options.baseUrl = uri.origin;

    _instance!.interceptors.addAll([
      DioUserAgentInterceptor(userAgent),
    ]);

    return _instance ??= DioClient._internal();
  }

  // Устанавливаем токен авторизации пользователя
  void setAuthInterceptor({
    required String accessToken,
    VoidCallback? unauthorizedCallback,
  }) {
    final DioAuthInterceptor interceptor = DioAuthInterceptor(
      unauthorizedCallback: unauthorizedCallback,
      token: accessToken,
    );
    unSetAuthInterceptor();

    interceptors.add(interceptor);
    currentToken = accessToken;
  }

  // Удалем токен автризации
  void unSetAuthInterceptor() {
    currentToken = '';
    interceptors.removeWhere((Interceptor element) {
      return element is DioAuthInterceptor;
    });
  }

  Map<String, Interceptor> interceptorWithNames = {};
  void addInterceptor(
      {required String name, required Interceptor interceptor}) {
    if (interceptorWithNames.containsKey(name)) {
      return;
    }
    interceptorWithNames[name] = interceptor;
    interceptors.add(interceptor);
  }

  void deleteInterceptor({required String name}) {
    interceptors.removeWhere((Interceptor element) {
      return element == interceptorWithNames[name];
    });
    interceptorWithNames.remove(name);
  }
}

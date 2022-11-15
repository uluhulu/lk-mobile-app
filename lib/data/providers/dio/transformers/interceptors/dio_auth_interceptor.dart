import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/resources/exception.dart';

/// Добавление авторизации
class DioAuthInterceptor extends Interceptor {
  DioAuthInterceptor({
    this.unauthorizedCallback,
    required this.token,
  });

  final String token;
  final VoidCallback? unauthorizedCallback;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers['X-Session-ID'] = token;
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) =>
      handler.next(response);

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    if (err.error is UnauthorizedException) {
      if (unauthorizedCallback is VoidCallback) {
        unauthorizedCallback!.call();
      }

      return;
    }

    handler.next(err);
  }
}

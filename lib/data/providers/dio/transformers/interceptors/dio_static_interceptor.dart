import 'package:dio/dio.dart';
import 'package:mkk/locator/locator.dart';
import 'package:mkk/services/env/env.dart';

/// Добавление авторизации
class DioStaticInterceptor extends Interceptor {
  DioStaticInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final env = sl.get<Env>();
    final needRestorePassword = options.headers['needRestore'];
    if (needRestorePassword != null) {
      handler.next(options);
      return;
    }
    options.headers['Authorization'] = env.vapidKey;
    handler.next(options);
  }
}

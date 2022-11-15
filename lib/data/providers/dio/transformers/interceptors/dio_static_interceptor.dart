import 'package:dio/dio.dart';

/// Добавление авторизации
class DioStaticInterceptor extends Interceptor {
  DioStaticInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers['Authorization'] =
        'Bearer DiIpELdxaqSNvw8Mo4F6DxwYqKdzupBirUun5hU5Ic4nPdTjJlzwSTwNPj0YiKEv';
    handler.next(options);
  }
}

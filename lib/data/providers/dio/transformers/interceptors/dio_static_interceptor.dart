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
        'Bearer VXfnb06pX8fxGrMJLDyXzSeJlOHdvGgUVb9wUArNQt3OMF0a9Y05QTw1dx95mxjy';
    handler.next(options);
  }
}

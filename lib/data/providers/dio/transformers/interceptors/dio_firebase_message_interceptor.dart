import 'package:dio/dio.dart';

/// Добавление токен файрбейс
class DioFirebaseMessageInterceptor extends Interceptor {
  DioFirebaseMessageInterceptor({this.token});

  final String? token;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers['FCM'] = token;
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) =>
      handler.next(response);

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) =>
      handler.next(err);
}

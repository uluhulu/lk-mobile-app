import 'package:dio/dio.dart';

/// Добавление User Agent
class DioUserAgentInterceptor extends Interceptor {
  DioUserAgentInterceptor(this.userAgent);

  final String userAgent;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers['User-Agent'] = userAgent + generateSecretCode();
    handler.next(options);
  }
}

///Средство защиты от спама смс
String generateSecretCode() {
  final date = DateTime.now().toUtc();
  final day = date.day;
  int hour = date.hour;
  if (hour == 0) {
    hour = 1;
  }
  final secret = (000000 * day * hour).toString();
  return secret.substring(secret.length - 4, secret.length);
}

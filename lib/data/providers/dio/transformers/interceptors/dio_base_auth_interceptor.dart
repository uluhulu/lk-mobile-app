import 'package:dio/dio.dart';

class DioBaseAuthInterceptor extends Interceptor {
  final String token;

  DioBaseAuthInterceptor(this.token);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $token';
  }
}

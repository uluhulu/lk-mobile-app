import 'package:dio/dio.dart';
import 'package:mkk/data/providers/dio/transformers/dio_client.dart';

import '../../../../../core/utils/resources/exception.dart';

typedef UnAuthCallBack = Future<String?> Function();

/// Добавление авторизации
class DioAuthInterceptor extends Interceptor {
  DioAuthInterceptor({
    this.unauthorizedCallback,
    required this.token,
  });

  String token;
  final UnAuthCallBack? unauthorizedCallback;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers['X-Session-ID'] = token;
    options.headers['Accept'] = 'application/json';
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) =>
      handler.next(response);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.error is UnauthorizedException) {
      if (unauthorizedCallback is UnAuthCallBack) {
        final String? newToken = await unauthorizedCallback!.call();
        if (newToken != null) {
          final dio = DioClient();
          try {
            final headers = err.requestOptions.headers;
            headers['X-Session-ID'] = newToken;
            token = newToken;
            final response = await dio.request(
              'https://lk-stage.puls.ru${err.requestOptions.path}',
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
              cancelToken: err.requestOptions.cancelToken,
              options: Options(
                method: err.requestOptions.method,
                sendTimeout: err.requestOptions.sendTimeout,
                receiveTimeout: err.requestOptions.receiveTimeout,
                extra: err.requestOptions.extra,
                headers: headers,
                responseType: err.requestOptions.responseType,
                contentType: err.requestOptions.contentType,
                validateStatus: err.requestOptions.validateStatus,
                receiveDataWhenStatusError:
                    err.requestOptions.receiveDataWhenStatusError,
                followRedirects: err.requestOptions.followRedirects,
                maxRedirects: err.requestOptions.maxRedirects,
                requestEncoder: err.requestOptions.requestEncoder,
                responseDecoder: err.requestOptions.responseDecoder,
                listFormat: err.requestOptions.listFormat,
              ),
            );
            handler.resolve(response);
            return;
          } catch (e) {
            handler.next(err);
            return;
          }
        }
      }

      handler.next(err);
      return;
    }

    handler.next(err);
    return;
  }
}

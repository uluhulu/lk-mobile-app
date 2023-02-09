import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../../../core/utils/resources/exception.dart';

/// Обработка ошибки с сервера
class DioErrorInterceptor extends Interceptor {
  DioErrorInterceptor();

  @override
  Future<void> onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    err.error = await _getDioException(err);
    handler.next(err);
  }

  Future<Exception> _getDioException(DioError error) async {
    switch (error.type) {
      case DioErrorType.cancel:
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        return TimeoutException(error.type.toString());
      case DioErrorType.other:
        final err = error.error;
        if (err is SocketException) {
          if (err.toString().contains("errno = 7")) {
            return HttpInternetException();
          }
        }
        Logger().d(err.toString());
        return UnexpectedException();
      case DioErrorType.response:
        if (error.response == null) {
          return ServerException(error.response?.data.toString() ?? '');
        }

        switch (error.response!.statusCode) {
          case 400:
            return BadRequestHttpException(error.response!);
          case 401:
          case 403:
            return UnauthorizedException();
          case 404:
            return NotFoundException();
          case 409:
            return ServerException(error.response!.data.toString());
          case 408:
            return TimeoutException(error.type.toString());
          case 422:
            return HttpValidateException(error.response!);
          case 500:
          case 503:
          case 504:
            return ServerException(error.response!.data.toString());
          default:
            Logger().d(error.error.toString());
            return UnexpectedException();
        }
    }
  }
}

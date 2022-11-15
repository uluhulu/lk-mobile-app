import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

abstract class Failure extends Equatable {
  final String message;
  final IconData icon;

  const Failure(
      [this.message = "Произошла ошибка", this.icon = Icons.error_outline]);
  @override
  List<Object?> get props => [message];
  @override
  bool? get stringify => true;
}

class SomethingGoWrong extends Failure {
  final String message;

  const SomethingGoWrong(this.message);

  @override
  IconData get icon => Icons.error;
}

class DefaultFailure extends Failure {
  const DefaultFailure();

  @override
  List<Object?> get props => [];
}

/// Неучтённая ошибка
class UnexpectedException implements Exception {}

class UnexpectedFailure extends Failure {
  UnexpectedFailure() : super('');

  @override
  List<Object?> get props => [];
}

class UnauthorizedException implements Exception {}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure()
      : super('Неизвестная ошибка. Мы обязательно её обнаружим и устраним');

  @override
  List<Object?> get props => [];
}

/// Неверный запрос (400)
class BadRequestHttpException implements Exception {
  BadRequestHttpException(this.response);

  /// Ответ от сервера
  final Response<dynamic> response;

  @override
  String toString() {
    final Map<String, String> data = response.data as Map<String, String>;
    return data['message']!;
  }
}

class BadRequestHttpFailure extends Failure {
  const BadRequestHttpFailure(String messageFromException)
      : super(messageFromException);
}

/// Страница не найдена
class NotFoundException implements Exception {}

class NotFoundFailure extends Failure {
  NotFoundFailure() : super('Страница не найдена');
}

///503, 500, 409 код от сервера
class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class ServerFailure extends Failure {
  ServerFailure() : super('Внутренняя ошибка сервера');
}

/// Исключение при пустом результате
class HttpEmptyDataException implements Exception {}

class HttpEmptyDataFailure extends Failure {
  HttpEmptyDataFailure() : super('Нет данных для отображения');
}

/// Исключение при недоступном соединении
class HttpInternetException implements Exception {}

class HttpInternetFailure extends Failure {
  HttpInternetFailure() : super('Отсутствует подключение к интернету');
}

class HttpRateLimitFailure extends Failure {
  HttpRateLimitFailure() : super('Превышено количество запросов');
}

/// Исключение при 422 ошибке от сервера
class HttpValidateException implements Exception {
  const HttpValidateException(this.response);

  final Response<dynamic> response;

  @override
  String toString() => _parseMessage() ?? '';

  String? _parseMessage() {
    if (response.data.isEmpty == true) {
      return null;
    }

    Map<String, String> data;
    Map<String, dynamic> map;

    if (response.data is List) {
      map = (response.data as List<dynamic>).first as Map<String, dynamic>;
    } else if (response.data is Map) {
      map = response.data as Map<String, dynamic>;
    } else {
      return null;
    }

    data = map.map((String key, dynamic value) => MapEntry<String, String>(
          key,
          value.toString(),
        ));

    if (data.containsKey('message') == true) {
      return data['message'];
    }

    return null;
  }
}

class HttpValidateFailure extends Failure {
  const HttpValidateFailure(String messageFromException)
      : super(messageFromException, Icons.error_outline);
}

/// Пустой ответ от сервера
class EmptyDataException implements Exception {}

class EmptyDataFailure extends Failure {
  EmptyDataFailure() : super('Пустой ответ от сервера');
}

///for TimeOutException
class TimeoutFailure extends Failure {
  TimeoutFailure()
      : super('Превышено время ожидание. Повторите попытку позднее',
            Icons.wifi_off);
}

class NoInvestorException implements Exception {}

class NotInvestorFailure implements Failure {
  @override
  IconData get icon => throw UnimplementedError();

  @override
  String get message => throw UnimplementedError();

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => true;
}

Failure processExceptions(dynamic throwable, StackTrace s) {
  switch (throwable.runtimeType) {
    case DioError:
      final subError = throwable.error;
      final message = throwable.error;

      switch (subError.runtimeType) {
        case UnauthorizedException:
          return UnauthorizedFailure();
        case BadRequestHttpException:
          return BadRequestHttpFailure(
              (subError as BadRequestHttpException).toString());
        case NotFoundException:
          return NotFoundFailure();
        case ServerException:
          return ServerFailure();
        case HttpEmptyDataException:
          return HttpEmptyDataFailure();
        case HttpInternetException:
          return HttpInternetFailure();
        case HttpValidateException:
          return HttpValidateFailure(
              (subError as HttpValidateException).toString());
        case EmptyDataException:
          return EmptyDataFailure();
        case TimeoutException:
          return TimeoutFailure();
        case UnexpectedException:
        default:
          Logger().d(
              "Не обработанное исключение для dio error.err: брошен объект типа: ${throwable.error.runtimeType}");
          return UnexpectedFailure();
      }
    case NoInvestorException:
      return NotInvestorFailure();
    default:
      Logger().d(
          "Не обработанное исключение: брошен объект типа: ${throwable.runtimeType}");
      return UnexpectedFailure();
  }
}

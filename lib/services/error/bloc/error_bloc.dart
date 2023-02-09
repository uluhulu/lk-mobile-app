import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/utils/resources/exception.dart';
import '../../../data/providers/repositories/exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

part 'error_event.dart';
part 'error_state.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(ErrorInitial()) {
    on<ErrorSimpleE>(_simple, transformer: droppable());
    on<ErrorFlutterE>(_flutter, transformer: droppable());
    on<AuthErrorE>(_authError, transformer: droppable());
    on<ErrorServerE>(_serverError, transformer: droppable());
  }

  FutureOr<void> _simple(ErrorSimpleE event, Emitter<ErrorState> emit) async {
    final error = event.error;

    final errorMessage = error.toString().split('(').last.split(')').first;
    if (error.runtimeType == HttpInternetFailure) {
      emit(ErrorNotificationS(
          title: 'Проблемы с интернетом',
          message: 'Подключитесь к другой сети или попробуйте еще раз'));
      return;
    }
    if (error.runtimeType == UnexpectedFailure) {
      emit(ErrorNotificationS(
          title: 'Непредвиденная ошибка',
          message: 'Неполадки на сервере, попробуйте позже'));
      return;
    }
    if (errorMessage != '') {
      emit(ErrorNotificationS(message: errorMessage.split(',').first));
      return;
    } else {
      emit(ErrorNotificationS(message: errorMessage));
      return;
    }
  }

  FutureOr<void> _flutter(ErrorFlutterE event, Emitter<ErrorState> emit) {
    emit(ErrorNotificationS(
      message: event.details.toString(),
    ));
  }

  FutureOr<void> _authError(AuthErrorE event, Emitter<ErrorState> emit) async {
    final error = event.error;
    if (error is LoginException) {
      if (error.error is DioError) {
        final dioError = error.error as DioError;
        if (dioError.response?.statusCode == 500) {
          emit(AuthErrorS(
            message: S.current.auth_server_error,
            subtitle: S.current.auth_server_error_subtitle,
          ));
          return;
        }
        if (dioError.response?.statusCode == 403) {
          emit(AuthErrorS(
            message: S.current.auth_server_error_403,
            subtitle: S.current.auth_server_error_subtitle,
          ));
          return;
        }
      }
      emit(AuthErrorS(
        message: S.current.auth_error_info,
        subtitle: S.current.auth_error_info_2,
      ));
      return;
    }
    if (error is ServerFailure) {
      emit(AuthErrorS(
        message: S.current.auth_server_error,
        subtitle: S.current.auth_server_error_subtitle,
      ));
      return;
    }
    final String parseErrorMesssage =
        error.toString().split('(').last.split(')').first;
    emit(ErrorNotificationS(message: parseErrorMesssage));
  }

  FutureOr<void> _serverError(ErrorServerE event, Emitter<ErrorState> emit) {
    emit(ErrorServerS(
      message: event.message,
    ));
  }

  void e(Object e, [StackTrace? stackTrace]) {
    add(ErrorServerE(
      message: kDebugMode ? e.toString() : 'Ошибка сервера',
    ));
  }
}

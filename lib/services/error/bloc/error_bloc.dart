import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import '../../../core/utils/resources/exception.dart';
import '../../../data/providers/repositories/exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
    // if (error is LoginException) {
    //   emit(ErrorNotificationS(message: 'Неверный логин или пароль'));
    //   return;
    // }
    final errorMessage = error.toString().split('(').last.split(')').first;
    if (error.runtimeType == HttpInternetFailure) {
      emit(ErrorNotificationS(
          title: 'Проблемы с интернетом',
          message: 'Подключитесь к другой сети или попробуйте еще раз'));
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
      emit(AuthErrorS(message: 'Неверный логин или пароль'));
      return;
    }
    emit(ErrorNotificationS(message: event.error.toString()));
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

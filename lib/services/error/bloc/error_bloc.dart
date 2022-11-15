import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../data/providers/repositories/exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'error_event.dart';
part 'error_state.dart';

class ErrorBloc extends Bloc<ErrorEvent, ErrorState> {
  ErrorBloc() : super(ErrorInitial()) {
    on<ErrorSimpleE>(_simple);
    on<ErrorFlutterE>(_flutter);
    on<AuthErrorE>(_authError);
  }

  FutureOr<void> _simple(ErrorSimpleE event, Emitter<ErrorState> emit) async {
    final error = event.error;
    // if (error is LoginException) {
    //   emit(ErrorNotificationS(message: 'Неверный логин или пароль'));
    //   return;
    // }
    emit(ErrorNotificationS(message: event.error.toString()));
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
}

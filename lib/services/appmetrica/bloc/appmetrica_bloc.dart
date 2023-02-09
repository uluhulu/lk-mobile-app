import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../appmetrica_service.dart';

part 'appmetrica_event.dart';

part 'appmetrica_state.dart';

class AppMetricaBloc extends Bloc<AppmetricaEvent, AppMetricaState> {
  final AppMetricaService appMetricaService;

  AppMetricaBloc({required this.appMetricaService})
      : super(AppmetricaInitialS()) {
    on<AppmetricaOnCrasheE>(onAppMetricaCrash);
    on<AppmetricaOnEventE>(onAppMetricaEvent);
  }

  FutureOr<void> onAppMetricaCrash(
      AppmetricaOnCrasheE event, Emitter<AppMetricaState> emit) async {
    try {
      await appMetricaService.onCrash(event.error,
          stackTrace: event.stackTrace);
    } catch (e) {}
  }

  FutureOr<void> onAppMetricaEvent(
      AppmetricaOnEventE event, Emitter<AppMetricaState> emit) async {
    try {
      await appMetricaService.onEvent(event.eventName);
    } catch (e) {}
  }
}

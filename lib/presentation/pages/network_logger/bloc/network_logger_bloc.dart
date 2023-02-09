import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'network_logger_event.dart';
part 'network_logger_state.dart';

class NetworkLoggerBloc extends Bloc<NetworkLoggerEvent, NetworkLoggerState> {
  NetworkLoggerBloc() : super(NetworkLoggerInitialS()) {
    on<NetworkLoggerShowE>(_onNetworkLoggerShowE);

    _initialize();
  }

  int counter = 0;

  FutureOr<void> _onNetworkLoggerShowE(
      NetworkLoggerShowE event, Emitter<NetworkLoggerState> emit) async {
    counter++;

    if (counter == 15) {
      emit(NetworkLoggerShowS());
      await Future<void>.delayed(const Duration(milliseconds: 2500), () {
        emit(NetworkLoggerInitialS());
        _initialize();
      });
    }
  }

  void _initialize() {
    counter = 0;
  }

  void incrementCounter() {
    counter++;
  }
}

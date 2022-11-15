import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mkk/services/error/bloc/error_bloc.dart';
import 'package:vibration/vibration.dart';

part 'validate_pin_state.dart';
part 'validate_pin_event.dart';

class ValidatePinBloc extends Bloc<ValidatePinEvent, ValidatePinState> {
  String pin = '';
  int maxLength = 4;

  StreamController<String> streamController = StreamController<String>();
  ValidatePinBloc() : super(const ValidatePinState('')) {
    on<ValidatePinPrintE>(_keyBoard);
    on<ValidatePinRemoveE>(_backSpace);
    on<ValidatePinErrorE>(_error);
  }

  int index = 0;

  FutureOr<void> _keyBoard(
      ValidatePinPrintE event, Emitter<ValidatePinState> emit) {
    pin += event.symbol;
    if (pin.length > maxLength) {
      pin = pin.substring(0, pin.length - 1);
    }
    emit(ValidatePinState(pin));
    streamController.add(pin);
  }

  FutureOr<void> _backSpace(
      ValidatePinRemoveE event, Emitter<ValidatePinState> emit) {
    pin = pin.substring(0, pin.length - 1);
    emit(ValidatePinState(pin));
    streamController.add(pin);
  }

  FutureOr<void> _error(
      ValidatePinErrorE event, Emitter<ValidatePinState> emit) async {
    if (index < 2) {
      index++;
      if (await Vibration.hasVibrator() ?? true) {
        Vibration.vibrate(duration: 300);
      }
      emit(ValidatePinState(pin, hasError: true));
    } else {
      if (await Vibration.hasVibrator() ?? true) {
        Vibration.vibrate(duration: 300, repeat: 3);
      }
      emit(ValidatePinState(pin, hasError: true, showErrorBanner: true));
    }
  }
}

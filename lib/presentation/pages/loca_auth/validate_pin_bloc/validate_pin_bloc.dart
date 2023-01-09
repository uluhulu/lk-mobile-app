import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../locator/locator.dart';
import '../../../../services/vibration/vibration_service.dart';

part 'validate_pin_state.dart';
part 'validate_pin_event.dart';

class ValidatePinBloc extends Bloc<ValidatePinEvent, ValidatePinState> {
  String pin = '';
  int maxLength = 4;

  StreamController<String> streamController = StreamController<String>();
  ValidatePinBloc() : super(const ValidatePinState(pin: '')) {
    on<ValidatePinPrintE>(_keyBoard);
    on<ValidatePinRemoveE>(_backSpace);
    on<ValidatePinErrorE>(_error);
  }

  int index = 1;

  FutureOr<void> _keyBoard(
      ValidatePinPrintE event, Emitter<ValidatePinState> emit) {
    pin += event.symbol;
    if (pin.length > maxLength) {
      pin = pin.substring(0, pin.length - 1);
    }
    emit(state.copyWith(
        pin: pin,
        showErrorBanner: false,
        redDot: false,
        newErrorBanner: false));
    streamController.add(pin);
  }

  FutureOr<void> _backSpace(
      ValidatePinRemoveE event, Emitter<ValidatePinState> emit) {
    pin = pin.substring(0, pin.length - 1);
    emit(state.copyWith(
        pin: pin,
        showErrorBanner: false,
        redDot: false,
        newErrorBanner: false));
    sl.get<VibrationService>().buttonVibrate();
    streamController.add(pin);
  }

  FutureOr<void> _error(
      ValidatePinErrorE event, Emitter<ValidatePinState> emit) async {
    switch (index) {
      case 0:
      case 1:
        index++;
        sl.get<VibrationService>().vibrate();
        pin = '';
        emit(ValidatePinState(pin: pin, hasError: true, redDot: true));

        streamController.add(pin);
        await Future.delayed(const Duration(milliseconds: 500));
        emit(state.copyWith(
            redDot: false, showErrorBanner: false, newErrorBanner: false));
        break;
      case 2:
        index++;
        sl.get<VibrationService>().vibrate();
        pin = '';
        emit(ValidatePinState(
          pin: pin,
          hasError: true,
          showErrorBanner: true,
          showNewErrorText: true,
          redDot: true,
          count: index,
        ));
        streamController.add(pin);
        await Future.delayed(const Duration(milliseconds: 500));
        emit(state.copyWith(
            redDot: false, showErrorBanner: false, newErrorBanner: false));
        break;
      case 3:
      case 4:
        index++;
        sl.get<VibrationService>().vibrate();
        pin = '';
        emit(ValidatePinState(
          pin: pin,
          hasError: true,
          showErrorBanner: false,
          showNewErrorText: true,
          newErrorBanner: index == 5 ? true : false,
          redDot: true,
          count: index,
        ));

        streamController.add(pin);
        await Future.delayed(const Duration(milliseconds: 500));
        emit(state.copyWith(
            redDot: index == 5 ? true : false,
            showErrorBanner: false,
            newErrorBanner: false));
        break;

      default:
        sl.get<VibrationService>().vibrate();
        pin = '';
        emit(ValidatePinState(
          pin: pin,
          hasError: true,
          showErrorBanner: false,
          showNewErrorText: true,
          newErrorBanner: true,
          redDot: true,
          count: 4,
        ));
        streamController.add(pin);
      // await Future.delayed(const Duration(milliseconds: 500));
      // emit(state.copyWith(
      //     redDot: false, showErrorBanner: false, newErrorBanner: false));
    }
  }
}

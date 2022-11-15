part of 'validate_pin_bloc.dart';

@immutable
abstract class ValidatePinEvent {}

class ValidatePinPrintE extends ValidatePinEvent {
  final String symbol;

  ValidatePinPrintE(this.symbol);
}

class ValidatePinRemoveE extends ValidatePinEvent {}

class ValidatePinErrorE extends ValidatePinEvent {}

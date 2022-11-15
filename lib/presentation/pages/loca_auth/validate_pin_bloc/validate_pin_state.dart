part of 'validate_pin_bloc.dart';

class ValidatePinState extends Equatable {
  final String pin;
  final bool hasError;
  final bool showErrorBanner;
  const ValidatePinState(
    this.pin, {
    this.hasError = false,
    this.showErrorBanner = false,
  });

  @override
  List<Object?> get props => [pin, hasError];
}

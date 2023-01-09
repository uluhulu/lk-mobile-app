// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'validate_pin_bloc.dart';

class ValidatePinState extends Equatable {
  final String pin;
  final bool hasError;
  final bool showErrorBanner;
  final bool showNewErrorText;
  final bool newErrorBanner;
  final int count;
  final bool redDot;
  const ValidatePinState({
    required this.pin,
    this.hasError = false,
    this.showErrorBanner = false,
    this.showNewErrorText = false,
    this.newErrorBanner = false,
    this.count = 0,
    this.redDot = false,
  });

  @override
  List<Object?> get props => [
        pin,
        hasError,
        showErrorBanner,
        showNewErrorText,
        newErrorBanner,
        count,
        redDot,
      ];

  ValidatePinState copyWith({
    String? pin,
    bool? hasError,
    bool? showErrorBanner,
    bool? showNewErrorText,
    bool? newErrorBanner,
    int? count,
    bool? redDot,
  }) {
    return ValidatePinState(
      pin: pin ?? this.pin,
      hasError: hasError ?? this.hasError,
      showErrorBanner: showErrorBanner ?? this.showErrorBanner,
      showNewErrorText: showNewErrorText ?? this.showNewErrorText,
      newErrorBanner: newErrorBanner ?? this.newErrorBanner,
      count: count ?? this.count,
      redDot: redDot ?? this.redDot,
    );
  }
}

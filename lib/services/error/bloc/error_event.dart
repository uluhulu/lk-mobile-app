part of 'error_bloc.dart';

@immutable
abstract class ErrorEvent extends Equatable {}

class ErrorFlutterE extends ErrorEvent {
  final FlutterErrorDetails details;
  ErrorFlutterE({
    required this.details,
  });

  @override
  List<Object?> get props => [details];
}

class ErrorSimpleE extends ErrorEvent {
  final Object? error;
  ErrorSimpleE(
    this.error,
  );

  @override
  List<Object?> get props => [error];
}

class AuthErrorE extends ErrorEvent {
  final Object? error;
  AuthErrorE(
    this.error,
  );

  @override
  List<Object?> get props => [error];
}

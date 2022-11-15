part of 'error_bloc.dart';

@immutable
abstract class ErrorState {}

class ErrorInitial extends ErrorState {}

class ErrorNotificationS extends ErrorState {
  final String? title;
  final String message;
  ErrorNotificationS({required this.message, this.title});
}

class AuthErrorS extends ErrorState {
  final String? title;
  final String message;
  AuthErrorS({required this.message, this.title});
}

part of 'restore_password_bloc.dart';

abstract class RestorePasswordState extends Equatable {
  const RestorePasswordState();

  @override
  List<Object?> get props => [];
}

class RestorePasswordInitialS extends RestorePasswordState {}

class RestorePasswordLoadingS extends RestorePasswordState {}

class RestorePasswordLoadedS extends RestorePasswordState {
  final DictionaryFilialEntity data;

  const RestorePasswordLoadedS({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}

class RestorePasswordEnterCodeS extends RestorePasswordState {
  final String? message;

  const RestorePasswordEnterCodeS({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class RestorePasswordEnterNewPasswordS extends RestorePasswordState {}

class ResetPasswordSuccessS extends RestorePasswordState {
  final String message;

  const ResetPasswordSuccessS({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class RestorePasswordErrorS extends RestorePasswordState {}

class RestorePasswordResetErrorS extends RestorePasswordState {}

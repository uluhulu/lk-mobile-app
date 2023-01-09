part of 'restore_password_bloc.dart';

abstract class RestorePasswordEvent extends Equatable {
  const RestorePasswordEvent();

  @override
  List<Object> get props => [];
}

class RestorePasswordFilialE extends RestorePasswordEvent {}

class RestorePasswordSendE extends RestorePasswordEvent {}

class RestorePasswordCheckCodeE extends RestorePasswordEvent {}

class RestorePasswordResetE extends RestorePasswordEvent {}

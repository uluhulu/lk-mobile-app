part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEventFetchFilialE extends LoginEvent {}

class LoginInitialE extends LoginEvent {}

class LoginEnterE extends LoginEvent {}

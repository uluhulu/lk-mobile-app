// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authorization_bloc.dart';

abstract class AuthorizationEvent extends Equatable {
  const AuthorizationEvent();

  @override
  List<Object> get props => [];
}

class AuthorizationLoginE extends AuthorizationEvent {
  final AuthLoginEntity loginEntity;
  final String login;
  final int filial;
  const AuthorizationLoginE({
    required this.loginEntity,
    required this.login,
    required this.filial,
  });

  @override
  List<Object> get props => [loginEntity, login, filial];
}

class AuthorizationLogOutE extends AuthorizationEvent {}

class AuthorizationInitializeE extends AuthorizationEvent {}

class AuthorizationLogOutCallBack extends AuthorizationEvent {}

class AuthorizationRightPinE extends AuthorizationEvent {}

class AuthorizationDeleteLocalAuthE extends AuthorizationEvent {}

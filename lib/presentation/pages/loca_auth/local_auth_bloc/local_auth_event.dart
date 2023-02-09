// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'local_auth_bloc.dart';

abstract class LocalAuthEvent extends Equatable {
  const LocalAuthEvent();

  @override
  List<Object> get props => [];
}

class LocalAuthInitializeE extends LocalAuthEvent {}

//class LocalAuthSetPinE extends LocalAuthEvent {}

class LocalAuthUnSetPinCodeE extends LocalAuthEvent {}

//class LocalAuthSetPinCodeE extends LocalAuthEvent {}

class LocalAuthReEnterE extends LocalAuthEvent {
  final String pin;
  const LocalAuthReEnterE({
    required this.pin,
  });

  @override
  List<Object> get props => [pin];
}

class LocalAuthEnteredE extends LocalAuthEvent {
  final String pin;
  const LocalAuthEnteredE({
    required this.pin,
  });

  @override
  List<Object> get props => [pin];
}

class LocalAuthDeletePinE extends LocalAuthEvent {}

class LocalAuthSuccessE extends LocalAuthEvent {
  final String pin;
  const LocalAuthSuccessE({
    required this.pin,
  });

  @override
  List<Object> get props => [pin];
}

class LocalAuthStartE extends LocalAuthEvent {}

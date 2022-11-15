part of 'restore_password_bloc.dart';

abstract class RestorePasswordEvent extends Equatable {
  const RestorePasswordEvent();

  @override
  List<Object> get props => [];
}

class RestorePasswordFilialE extends RestorePasswordEvent {}

class RestorePasswordSendE extends RestorePasswordEvent {
  final String login;
  final int filial;

  const RestorePasswordSendE({
    required this.login,
    required this.filial,
  });

  @override
  List<Object> get props => [login, filial];
}

class RestorePasswordToggleCompanyE extends RestorePasswordEvent {
  final DictionaryData company;

  const RestorePasswordToggleCompanyE({
    required this.company,
  });

  @override
  List<Object> get props => [company];
}

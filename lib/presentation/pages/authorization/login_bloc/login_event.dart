part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEventFetchFilialE extends LoginEvent {}

class LoginEventToggleCompanyE extends LoginEvent {
  final DictionaryData company;

  const LoginEventToggleCompanyE({
    required this.company,
  });

  @override
  List<Object> get props => [company];
}

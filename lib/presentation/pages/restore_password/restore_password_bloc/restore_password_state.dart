part of 'restore_password_bloc.dart';

abstract class RestorePasswordState extends Equatable {
  const RestorePasswordState();

  @override
  List<Object> get props => [];
}

class RestorePasswordInitialS extends RestorePasswordState {}

class RestorePasswordLoadingS extends RestorePasswordState {}

class RestorePasswordLoadedS extends RestorePasswordState {
  final DictionaryFilialEntity data;
  final DictionaryData company;

  const RestorePasswordLoadedS({
    required this.data,
    required this.company,
  });

  @override
  List<Object> get props => [data, company];
}

class RestorePasswordEnterCodeS extends RestorePasswordState {}

class RestorePasswordErrorS extends RestorePasswordState {}

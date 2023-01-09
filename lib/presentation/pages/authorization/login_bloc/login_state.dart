// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialS extends LoginState {}

class LoginSplashLoadingS extends LoginState {}

class LoginLoadingS extends LoginState {}

class LoginLoadedS extends LoginState {
  final DictionaryFilialEntity data;
  // final DictionaryData company;

  const LoginLoadedS({
    required this.data,
    //required this.company,
  });

  @override
  List<Object> get props => [data];

  LoginLoadedS copyWith({
    DictionaryFilialEntity? data,
  }) {
    return LoginLoadedS(
      data: data ?? this.data,
    );
  }
}

class LoginErrorS extends LoginState {}

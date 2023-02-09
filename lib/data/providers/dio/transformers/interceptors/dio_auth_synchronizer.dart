// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:injectable/injectable.dart';

import 'package:mkk/data/providers/local_store_provider.dart';
import 'package:mkk/domain/repositories/repository.dart';
import 'package:mkk/domain/repositories/user_repository.dart';
import 'package:mkk/locator/locator.dart';

import '../../../../models/auth_credentials_model.dart';
import '../dio_client.dart';

@singleton
class AuthSynchronizer {
  LocalStoreProvider get _store => sl.get<LocalStoreProvider>();

  Repository get _repository => sl.get<Repository>();

  UserRepository get _userRepository => sl.get<UserRepository>();

  Future<void> saveAuthCredentials(AuthCredentialsModel authCredentials) async {
    await _store.setAuthCred(authCredentials);
    await _userRepository.saveUserLogin(authCredentials.login);
    await _userRepository.saveRegionalCompany(authCredentials.filial);
    await _userRepository.savePassword(authCredentials.password);
  }

  AuthCredentialsModel? get currentCred => _store.getAuthCred;

  final StreamController<bool> _isLoginController =
      StreamController<bool>.broadcast();

  Stream<bool> get isLoginStream => _isLoginController.stream;

  Future<AuthCredentialsModel> login({
    required String login,
    required String password,
    required int filial,
  }) async {
    final newLogin = await _repository.login(
      login: login,
      password: password,
      filial: filial,
    );
    final authCred = AuthCredentialsModel(
      login: login,
      password: password,
      filial: filial,
      token: newLogin.data.sessionId,
      isLogin: newLogin.data.isLogin,
    );
    await saveAuthCredentials(authCred);

    return authCred;
  }

  Future<String?> unauthorizedCallback() async {
    final authCred = _store.getAuthCred;
    final pinCode = _userRepository.getLocalAuthPin();
    // if (pinCode == null) {
    //   _isLoginController.add(false);
    //   return null;
    // }
    if (authCred != null) {
      try {
        final newLogin = await _repository.login(
          login: authCred.login,
          password: authCred.password,
          filial: authCred.filial,
        );

        await saveAuthCredentials(authCred.copyWith(
          token: newLogin.data.sessionId,
          isLogin: newLogin.data.isLogin,
        ));

        return newLogin.data.sessionId;
      } catch (e) {
        _isLoginController.add(false);
        return null;
      }
    } else {
      _isLoginController.add(false);
      return null;
    }
  }

  void initialize() {
    final authCred = _store.getAuthCred;
    DioClient().setAuthInterceptor(
      accessToken: authCred?.token ?? '',
      unauthorizedCallback: () => unauthorizedCallback(),
    );
  }

  void test() {
    DioClient().setAuthInterceptor(
      accessToken: 'error',
      unauthorizedCallback: () => unauthorizedCallback(),
    );
  }
}

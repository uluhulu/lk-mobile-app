import 'package:mkk/data/api/auth/forgot_password/params/auth_forgot_password_params.dart';
import 'package:mkk/data/api/auth/login/entity/auth_login_entity.dart';
import 'package:mkk/data/api/dictionary/filials/entity/dictionary_filials_entity.dart';
import 'package:mkk/data/api/profile/info/entity/profile_info_entity.dart';
import 'package:mkk/data/api/receivables/info/entity/receivables_info_entity.dart';

import '../../data/api/profile/act/params/profile_act_params.dart';

abstract class Repository {
  const Repository();

  bool get authorized;
  set authorized(bool value);

  Future<AuthLoginEntity> login({
    required String login,
    required String password,
    required int filial,
  });

  Future<DictionaryFilialEntity> dictionaryFilialList();

  Future<void> forgotPassword(AuthForgotPasswordParams params);

  Future<void> logout();

  Future<ProfileInfoEntity> getProfile();

  Future<void> getProfileAct(ProfileActParams params);

  Future<ReceivablesInfoEntity> receivablesInfo();
}

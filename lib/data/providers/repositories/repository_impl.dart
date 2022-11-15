import 'package:curl_logger_dio_interceptor_modeck/curl_logger_dio_interceptor_modeck.dart';
import 'package:flutter/foundation.dart';
import 'package:mkk/data/api/auth/forgot_password/params/auth_forgot_password_params.dart';
import 'package:mkk/data/api/auth/login/entity/auth_login_entity.dart';
import 'package:mkk/data/api/auth/login/params/auth_login_params.dart';
import 'package:mkk/data/api/dictionary/filials/entity/dictionary_filials_entity.dart';
import 'package:mkk/data/api/profile/act/params/profile_act_params.dart';
import 'package:mkk/data/api/receivables/info/entity/receivables_info_entity.dart';
import 'package:mkk/data/providers/dio/transformers/dio_client.dart';
import 'package:injectable/injectable.dart';
import 'package:mkk/data/providers/api_provider.dart';
import 'package:mkk/services/logger/logger_service.dart';
import '../../../core/utils/resources/exception.dart';
import '../../../domain/repositories/network_info_repository.dart';
import '../../../domain/repositories/repository.dart';

import '../../../domain/repositories/user_repository.dart';
import '../../api/profile/info/entity/profile_info_entity.dart';
import '../dio/transformers/interceptors/dio_static_interceptor.dart';
import 'exceptions.dart';

@LazySingleton(as: Repository)
class RepositoryImpl implements Repository {
  final NetworkInfo networkInfo;
  final UserRepository userRepository;

  RepositoryImpl({
    required this.networkInfo,
    required this.userRepository,
  });

  late final ApiProvider _apiProvider = makeApiProvider();
  ApiProvider makeApiProvider() {
    final dioClient = DioClient();
    if (kDebugMode) {
      dioClient.interceptors
          .add(CurlLoggerDioInterceptor(printOnSuccess: true));
    }
    dioClient.interceptors.add(DioStaticInterceptor());

    return ApiProvider(
      dioClient,
      baseUrl: 'https://lk-stage.puls.ru',
    );
  }

  // final DioClient _dioClient = DioClient()
  //   ..addInterceptor(
  //       name: 'curl',
  //       interceptor: CurlLoggerDioInterceptor(printOnSuccess: true));
  // late final ApiProvider _apiProvider = ApiProvider(
  //   _dioClient,
  //   baseUrl: 'https://lk-stage.puls.ru',
  // );

  @override
  bool get authorized => _isAuthorized;

  @override
  set authorized(bool value) {
    _isAuthorized = value;
  }

  bool _isAuthorized = false;

  // final String authToken =
  //     'Bearer DiIpELdxaqSNvw8Mo4F6DxwYqKdzupBirUun5hU5Ic4nPdTjJlzwSTwNPj0YiKEv';

  static Future<R> _baseRequest<R>({
    required Future<R> Function() apiQuery,
  }) async {
    // if (await networkInfo.isConnected) {
    try {
      final r = await apiQuery();
      return r;
    } catch (e, s) {
      final failure = processExceptions(e, s);
      L.e('Execption $e \n stackTrace: ${s}');
      //TODO: прикрутить крашлитику (firebase/appmetrica)
      throw failure;
    }
  }

  @override
  Future<AuthLoginEntity> login({
    required String login,
    required String password,
    required int filial,
  }) async {
    try {
      final response = await _apiProvider.login(
          AuthLoginParams(username: login, password: password, filial: filial));

      DioClient().setAuthInterceptor(accessToken: response.data.data.sessionId);
      return response.data;
    } catch (e, s) {
      L.e('login execption $e \n stackTrace: ${s}');
      throw LoginException();
    }
  }

  @override
  Future<DictionaryFilialEntity> dictionaryFilialList() async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.dictionaryFilialList();
        return result.data;
      });

  @override
  Future<void> forgotPassword(AuthForgotPasswordParams params) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.forgotPassword(params);
        return result.data;
      });

  @override
  Future<void> logout() async {
    _isAuthorized = false;
    return _baseRequest(apiQuery: () async {
      final result = await _apiProvider.logout();
      return result.data;
    });
  }

  @override
  Future<ProfileInfoEntity> getProfile() async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.getProfile();
        return result.data;
      });

  @override
  Future<void> getProfileAct(ProfileActParams params) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.getProfileAct(params);
        return result.data;
      });

  @override
  Future<ReceivablesInfoEntity> receivablesInfo() async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.receivablesInfo();
        return result.data;
      });
}

import 'package:curl_logger_dio_interceptor_modeck/curl_logger_dio_interceptor_modeck.dart';
import 'package:flutter/foundation.dart';
import 'package:mkk/data/api/auth/forgot_password/params/auth_forgot_password_params.dart';
import 'package:mkk/data/api/auth/login/entity/auth_login_entity.dart';
import 'package:mkk/data/api/auth/login/params/auth_login_params.dart';
import 'package:mkk/data/api/auth/reset_password_code/params/reset_password_code_params.dart';
import 'package:mkk/data/api/auth/reset_password_code/params/reset_password_with_code_params.dart';
import 'package:mkk/data/api/claim_drafts/add_products/entity/claim_drafts_add_products_entity.dart';
import 'package:mkk/data/api/claim_drafts/create/params/claim_drafts_create_params.dart';
import 'package:mkk/data/api/claim_drafts/info/entity/claim_drafts_info_entity.dart';
import 'package:mkk/data/api/claim_drafts/list/params/claim_drafts_list_params.dart';
import 'package:mkk/data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import 'package:mkk/data/api/claim_drafts/products/params/claim_drafts_products_params.dart';
import 'package:mkk/data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import 'package:mkk/data/api/claim_drafts/save/entity/claim_drafts_save_entity.dart';
import 'package:mkk/data/api/claim_drafts/send/entity/claim_drafts_send_entity.dart';
import 'package:mkk/data/api/claims/find/params/search_claims_params.dart';
import 'package:mkk/data/api/claims/find/entity/search_claims_entity.dart';
import 'package:mkk/data/api/claims/main/params/claims_params.dart';
import 'package:mkk/data/api/claims/main/entity/claims_entity.dart';
import 'package:mkk/data/api/claims/products/entity/claims_detail_products_entity.dart';
import 'package:mkk/data/api/dictionary/filials/entity/dictionary_filials_entity.dart';
import 'package:mkk/data/api/invoices/detail/params/invoices_detail_params.dart';
import 'package:mkk/data/api/invoices/detail/entity/invoices_detail_entity.dart';
import 'package:mkk/data/api/invoices/detail/products/params/invoices_detail_products_params.dart';
import 'package:mkk/data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';
import 'package:mkk/data/api/invoices/find/params/invoices_find_params.dart';
import 'package:mkk/data/api/invoices/find/entity/invoices_find_entity.dart';
import 'package:mkk/data/api/invoices/list/params/invoices_list_params.dart';
import 'package:mkk/data/api/invoices/list/entity/invoices_entity.dart';
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
import '../../api/auth/reset_password_code/entity/reset_password_code_entity.dart';
import '../../api/claim_drafts/create/entity/claim_draft_create_entity.dart';
import '../../api/claim_drafts/delete_products/params/claim_drafts_delete_products_params.dart';
import '../../api/claim_drafts/save/params/claim_drafts_save_params.dart';
import '../../api/claims/detail/entity/claim_detail_entity.dart';
import '../../api/profile/info/entity/profile_info_entity.dart';
import '../dio/transformers/interceptors/dio_static_interceptor.dart';
import 'exceptions.dart';
//import 'package:dio_smart_retry/dio_smart_retry.dart';

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
    // dioClient.interceptors.add(RetryInterceptor(
    //   dio: dioClient,
    //   //logPrint: print,
    //   retries: 3,
    //   retryDelays: const [
    //     Duration(seconds: 1),
    //     Duration(seconds: 2),
    //     Duration(seconds: 3),
    //   ],
    // ));

    return ApiProvider(
      dioClient,
      baseUrl: 'https://lk-stage.puls.ru',
    );
  }

  @override
  bool get authorized => _isAuthorized;

  @override
  set authorized(bool value) {
    _isAuthorized = value;
  }

  bool _isAuthorized = false;

  static Future<R> _baseRequest<R>({
    required Future<R> Function() apiQuery,
  }) async {
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
  Future<ResetPasswordCodeEntity> forgotPassword(
          AuthForgotPasswordParams params) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.forgotPassword(params);
        return result.data;
      });

  @override
  Future<void> resetPasswordCode(ResetPasswordCodeParams params) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.resetPasswordCode(params);
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

  @override
  Future<InvoicesEntity> invoices(InvoicesListParams params) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.invoices(params);
        return result.data;
      });

  @override
  Future<InvoicesDetailEntity> invoicesDetail(
          InvoicesDetailParams params) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.invoicesDetail(params.uuid);
        return result.data;
      });

  @override
  Future<InvoicesDetailProductsEntity> invoicesDetailProducts(
          InvoicesDetailProductsParams params) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.invoicesDetailProducts(params.uuid);
        return result.data;
      });

  @override
  Future<ClaimsEntity> claims(ClaimsParams params) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.claims(params);
        return result.data;
      });

  @override
  Future<InvoicesFindEntity> invoicesSearch(InvoicesFindParams params) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.invoicesSearch(params);
        return result.data;
      });

  @override
  Future<ResetPasswordCodeEntity> resetPasswordWithCode(
          ResetPasswordWithCodeParams params) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.resetPasswordWithCode(params);
        return result.data;
      });

  @override
  Future<SearchClaimsEntity> claimsSearch(SearchClaimsParams params) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.searchClaims(params);
        return result.data;
      });

  @override
  Future<ClaimsDetailProductsEntity> claimsDetailProducts(String uuid) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.claimsDetailProducts(uuid);
        return result.data;
      });

  @override
  Future<ClaimDetailEntity> claimsDetail(String uuid) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.claimsDetail(uuid);
        return result.data;
      });

  @override
  Future<ClaimDraftsListEntity> claimDraftsList(
          ClaimDraftsListParams params) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.claimDraftsList(params);
        return result.data;
      });

  @override
  Future<void> claimDraftsDelete(int uuid) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.claimDraftsDelete(uuid);
        return result.data;
      });

  @override
  Future<ClaimDraftsInfoEntity> claimDraftsInfo(int id) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.claimDraftsInfo(id);
        return result.data;
      });

  @override
  Future<ClaimDraftsProductsEntity> claimDraftProducts(
          int id, ClaimDraftsProductsParams params) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.claimDraftsProducts(id, params);
        return result.data;
      });

  @override
  Future<ClaimDraftsSendEntity> claimDraftSend(int id) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.claimDraftsSend(id);
        return result.data;
      });

  @override
  Future<dynamic> claimDraftsSave(
    int id,
    ClaimDraftsSaveParams params,
  ) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.claimDraftsSave(id, params);
        return result.data;
      });

  @override
  Future<ClaimDraftsAddProductsEntity> claimDraftsAddProducts(int id) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.claimDraftsAddProducts(id);
        return result.data;
      });

  @override
  Future<void> claimDraftsDeleteProducts(
          {required int id,
          required ClaimDraftsDeleteProductsParams params}) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.claimDraftsDeleteProducts(id, params);
        return result.data;
      });

  @override
  Future<ClaimDraftCreateEntity> claimDraftsCreate(
          ClaimDraftsCreateParams params) async =>
      _baseRequest(apiQuery: () async {
        final result = await _apiProvider.claimDraftsCreate(params);
        return result.data;
      });
}

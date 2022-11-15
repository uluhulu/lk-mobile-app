import 'package:dio/dio.dart';
import 'package:mkk/data/api/auth/forgot_password/params/auth_forgot_password_params.dart';
import 'package:mkk/data/api/auth/login/entity/auth_login_entity.dart';
import 'package:mkk/data/api/auth/login/params/auth_login_params.dart';
import 'package:mkk/data/api/auth/reset_password/params/auth_reset_password_params.dart';
import 'package:mkk/data/api/claim/create/entity/claim_create_entity.dart';
import 'package:mkk/data/api/claim/create/params/claim_create_params.dart';
import 'package:mkk/data/api/claim/find/entity/claim_find_entity.dart';
import 'package:mkk/data/api/claim/find/params/claim_find_params.dart';
import 'package:mkk/data/api/claim/update/entity/claim_update_entity.dart';
import 'package:mkk/data/api/claim/update/params/claim_update_params.dart';
import 'package:mkk/data/api/dictionary/filials/entity/dictionary_filials_entity.dart';
import 'package:mkk/data/api/profile/info/entity/profile_info_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../api/invoices/list/entity/invoices_list_entity.dart';
import '../api/invoices/list/params/invoices_list_params.dart';
import '../api/profile/act/params/profile_act_params.dart';
import '../api/receivables/info/entity/receivables_info_entity.dart';

part 'api_provider.g.dart';

/// Api клиент
@RestApi()
abstract class ApiProvider {
  factory ApiProvider(Dio dio, {String baseUrl}) = _ApiProvider;

  /// ПРЕТЕНЗИИ

  // Возвращает список документов претензия клиента.
  @POST('/api/claim/find')
  Future<HttpResponse<ClaimFindEntity>> findClaim(
    @Body() ClaimFindParams params,
  );

  // Создает документ Претензия клиента
  @POST('/api/claim/create/')
  Future<HttpResponse<ClaimCreateEntity>> createClaim(
    @Body() ClaimCreateParams params,
  );

  // Изменяет текущий документ претензия
  @POST('/api/claim/update')
  Future<HttpResponse<ClaimUpdateEntity>> updateClaim(
    @Body() ClaimUpdateParams params,
  );

  /// СПРАВОЧНИКИ

  // Список региональных компаний
  @GET('/api/dictionary/filials')
  Future<HttpResponse<DictionaryFilialEntity>> dictionaryFilialList();

  /// ПОЛЬЗОВАТЕЛЬ

  // Аутентификация пользователя
  @POST('/api/auth/login')
  Future<HttpResponse<AuthLoginEntity>> login(
    @Body() AuthLoginParams params,
  );

  // Выход пользователя
  @POST('/api/auth/logout')
  Future<HttpResponse<dynamic>> logout();

  // Сброс пароля
  @POST('/api/auth/forgot-password')
  Future<HttpResponse<dynamic>> forgotPassword(
    @Body() AuthForgotPasswordParams params,
  );

  @POST('/api/auth/reset-password')
  Future<HttpResponse<dynamic>> createDocument(
    @Body() AuthResetPasswordParams params,
  );

  @GET('/api/profile')
  Future<HttpResponse<ProfileInfoEntity>> getProfile();

  @POST('/api/profile/act')
  Future<HttpResponse<dynamic>> getProfileAct(
    @Body() ProfileActParams params,
  );

  /// ДЕБИТОРСКАЯ ЗАДОЛЖЕННОСТЬ

  @GET('/api/receivables/info')
  Future<HttpResponse<ReceivablesInfoEntity>> receivablesInfo();

  /// НАКЛАДНЫЕ

  @POST('/api/invoices')
  Future<HttpResponse<InvoicesListEntity>> invoicesList(
    @Body() InvoicesListParams params,
  );
}

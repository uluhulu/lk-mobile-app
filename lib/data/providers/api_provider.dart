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
import '../api/auth/reset_password_code/entity/reset_password_code_entity.dart';
import '../api/auth/reset_password_code/params/reset_password_code_params.dart';
import '../api/auth/reset_password_code/params/reset_password_with_code_params.dart';
import '../api/claim_draft_overages/add_overages/params/claim_drafts_add_overages_params.dart';
import '../api/claim_draft_overages/find_overages/entity/claim_drafts_find_overages_entity.dart';
import '../api/claim_draft_overages/find_overages/params/claim_drafts_find_overage_params.dart';
import '../api/claim_drafts/add_products/entity/claim_drafts_add_products_entity.dart';
import '../api/claim_drafts/claim_draft_attachment/entity/claim_draft_attachment_entity.dart';
import '../api/claim_drafts/claim_draft_attachments/add_claim_draft_attachments/entity/add_claim_draft_attachments_entity.dart';
import '../api/claim_drafts/claim_draft_attachments/add_claim_draft_attachments/params/add_claim_draft_attachments_params.dart';
import '../api/claim_drafts/create/entity/claim_draft_create_entity.dart';
import '../api/claim_drafts/create/params/claim_drafts_create_params.dart';
import '../api/claim_drafts/delete_products/params/claim_drafts_delete_products_params.dart';
import '../api/claim_drafts/info/entity/claim_drafts_info_entity.dart';
import '../api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import '../api/claim_drafts/list/params/claim_drafts_list_params.dart';
import '../api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../api/claim_drafts/products/params/claim_drafts_products_params.dart';
import '../api/claim_drafts/save/params/claim_drafts_save_params.dart';
import '../api/claim_drafts/send/entity/claim_drafts_send_entity.dart';
import '../api/claims/detail/entity/claim_detail_entity.dart';
import '../api/claims/find/entity/search_claims_entity.dart';
import '../api/claims/find/params/search_claims_params.dart';
import '../api/claims/main/entity/claims_entity.dart';
import '../api/claims/main/params/claims_params.dart';
import '../api/claims/attachments/entity/claim_new_attachment_entity.dart';
import '../api/claims/attachments/params/claim_new_attachment_params.dart';
import '../api/claims/products/entity/claims_detail_products_entity.dart';
import '../api/help/entity/help_entity.dart';
import '../api/invoices/detail/entity/invoices_detail_entity.dart';
import '../api/invoices/detail/products/entity/invoices_detail_products_entity.dart';
import '../api/invoices/detail/products/params/invoices_detail_products_params.dart';
import '../api/invoices/find/entity/invoices_find_entity.dart';
import '../api/invoices/find/params/invoices_find_params.dart';
import '../api/invoices/list/entity/invoices_entity.dart';
import '../api/invoices/list/params/invoices_list_params.dart';
import '../api/profile/act/params/profile_act_params.dart';
import '../api/receivables/info/entity/receivables_info_entity.dart';

part 'api_provider.g.dart';

@RestApi()
abstract class ApiProvider {
  factory ApiProvider(Dio dio, {String baseUrl}) = _ApiProvider;

  /// ПРЕТЕНЗИИ

  @GET('/api/claims')
  Future<HttpResponse<ClaimsEntity>> claims(
    @Queries() ClaimsParams params,
  );

  @GET('/api/claims/find')
  Future<HttpResponse<SearchClaimsEntity>> searchClaims(
    @Queries() SearchClaimsParams params,
  );

  @GET('/api/claims/{uuid}/products')
  Future<HttpResponse<ClaimsDetailProductsEntity>> claimsDetailProducts(
    @Path('uuid') String uuid,
  );

  @GET('/api/claims/{uuid}')
  Future<HttpResponse<ClaimDetailEntity>> claimsDetail(
    @Path('uuid') String uuid,
  );

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

  @POST('/api/claims/attachments/product/base64')
  Future<HttpResponse<ClaimsNewAttachmentsEntity>> updateClaimAttachments(
    @Body() ClaimsNewAttachmentsParams params,
  );

  @GET('/api/claims/attachments/remote')
  Future<HttpResponse<ImageData>> getClaimsImage(
    @Query("path") String path,
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
  Future<HttpResponse<ResetPasswordCodeEntity>> forgotPassword(
    @Body() AuthForgotPasswordParams params,
    @Header('Authorization') String token,
    @Header('needRestore') String needRestore,
  );

  @POST('/api/auth/check-reset-password-code')
  Future<HttpResponse<dynamic>> resetPasswordCode(
    @Body() ResetPasswordCodeParams params,
  );

  @POST('/api/auth/reset-password-code')
  Future<HttpResponse<ResetPasswordCodeEntity>> resetPasswordWithCode(
    @Body() ResetPasswordWithCodeParams params,
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

  @GET('/api/invoices')
  Future<HttpResponse<InvoicesEntity>> invoices(
    @Queries() InvoicesListParams params,
  );

  @GET('/api/invoices/{uuid}')
  Future<HttpResponse<InvoicesDetailEntity>> invoicesDetail(
    @Path('uuid') String uuid,
  );

  @GET('/api/invoices/{uuid}/products')
  Future<HttpResponse<InvoicesDetailProductsEntity>> invoicesDetailProducts(
    @Path('uuid') String uuid,
    @Queries() InvoicesDetailProductsParams params,
  );

  @GET('/api/invoices/find')
  Future<HttpResponse<InvoicesFindEntity>> invoicesSearch(
    @Queries() InvoicesFindParams params,
  );

  /// Черновики претензий

  @GET('/api/claim-drafts/list')
  Future<HttpResponse<ClaimDraftsListEntity>> claimDraftsList(
    @Queries() ClaimDraftsListParams params,
  );

  @GET('/api/claim-drafts/{id}')
  Future<HttpResponse<ClaimDraftsInfoEntity>> claimDraftsInfo(
    @Path('id') int id,
  );

  @DELETE('/api/claim-drafts/{id}')
  Future<HttpResponse<dynamic>> claimDraftsDelete(
    @Path('id') int id,
  );

  @GET('/api/claim-drafts/{id}/products')
  Future<HttpResponse<ClaimDraftsProductsEntity>> claimDraftsProducts(
    @Path('id') int id,
    @Queries() ClaimDraftsProductsParams params,
  );

  @POST('/api/claim-drafts/{id}/send')
  Future<HttpResponse<ClaimDraftsSendEntity>> claimDraftsSend(
    @Path('id') int id,
  );

  @POST('/api/claim-drafts/{id}')
  Future<HttpResponse<dynamic>> claimDraftsSave(
    @Path('id') int id,
    @Body() ClaimDraftsSaveParams params,
  );

  @POST('/api/claim-drafts/{id}/products')
  Future<HttpResponse<ClaimDraftsAddProductsEntity>> claimDraftsAddProducts(
    @Path('id') int id,
  );

  @DELETE('/api/claim-drafts/{id}/products')
  Future<HttpResponse<dynamic>> claimDraftsDeleteProducts(
    @Path('id') int id,
    @Body() ClaimDraftsDeleteProductsParams params,
  );

  @POST('/api/claim-drafts/create')
  Future<HttpResponse<ClaimDraftCreateEntity>> claimDraftsCreate(
    @Body() ClaimDraftsCreateParams params,
  );

  @GET('/api/help/list/{roleId}')
  Future<HttpResponse<HelpEntity>> getHelp(
    @Path('roleId') int roleId,
  );

  @GET('{icon}')
  Future<HttpResponse<dynamic>> getHelpIcon(
    @Path('icon') String icon,
  );

  @GET('/api/claim-drafts/find-overages')
  Future<HttpResponse<ClaimDraftsFindOveragesEntity>> claimDraftsFindOverages(
    @Queries() ClaimDraftsFindOveragesParams params,
  );

  @POST('/api/claim-drafts/{id}/add-overage')
  Future<HttpResponse<dynamic>> claimDraftsAddOverages(
    @Body() ClaimDraftAddOveragesParams params,
    @Path('id') int id,
  );

  @POST('/api/claim-drafts/attachments/upload')
  Future<HttpResponse<AddClaimDraftAttachmentsEntity>>
      updateClaimDraftAttachments(
    @Body() AddClaimDraftAttachmentsParams params,
  );

  @GET('/api/claim-drafts/attachments/{id}')
  Future<HttpResponse<ClaimDraftAttachmentEntity>> getClaimDraftImage(
    // @Query("path") String path,
    @Path('id') int id,
  );

  @DELETE('/api/claim-drafts/attachments/{id}')
  Future<HttpResponse<dynamic>> deleteClaimDraftImage(
    // @Query("path") String path,
    @Path('id') int id,
  );
}

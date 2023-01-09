import 'package:mkk/data/api/auth/forgot_password/params/auth_forgot_password_params.dart';
import 'package:mkk/data/api/auth/login/entity/auth_login_entity.dart';
import 'package:mkk/data/api/auth/reset_password_code/params/reset_password_with_code_params.dart';
import 'package:mkk/data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import 'package:mkk/data/api/claim_drafts/products/params/claim_drafts_products_params.dart';
import 'package:mkk/data/api/claims/find/entity/search_claims_entity.dart';
import 'package:mkk/data/api/claims/main/params/claims_params.dart';
import 'package:mkk/data/api/dictionary/filials/entity/dictionary_filials_entity.dart';
import 'package:mkk/data/api/invoices/detail/params/invoices_detail_params.dart';
import 'package:mkk/data/api/profile/info/entity/profile_info_entity.dart';
import 'package:mkk/data/api/receivables/info/entity/receivables_info_entity.dart';

import '../../data/api/auth/reset_password_code/entity/reset_password_code_entity.dart';
import '../../data/api/auth/reset_password_code/params/reset_password_code_params.dart';
import '../../data/api/claim_drafts/add_products/entity/claim_drafts_add_products_entity.dart';
import '../../data/api/claim_drafts/create/entity/claim_draft_create_entity.dart';
import '../../data/api/claim_drafts/create/params/claim_drafts_create_params.dart';
import '../../data/api/claim_drafts/delete_products/params/claim_drafts_delete_products_params.dart';
import '../../data/api/claim_drafts/info/entity/claim_drafts_info_entity.dart';
import '../../data/api/claim_drafts/list/params/claim_drafts_list_params.dart';
import '../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../data/api/claim_drafts/save/entity/claim_drafts_save_entity.dart';
import '../../data/api/claim_drafts/save/params/claim_drafts_save_params.dart';
import '../../data/api/claim_drafts/send/entity/claim_drafts_send_entity.dart';
import '../../data/api/claims/detail/entity/claim_detail_entity.dart';
import '../../data/api/claims/find/params/search_claims_params.dart';
import '../../data/api/claims/main/entity/claims_entity.dart';
import '../../data/api/claims/products/entity/claims_detail_products_entity.dart';
import '../../data/api/invoices/detail/entity/invoices_detail_entity.dart';
import '../../data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';
import '../../data/api/invoices/detail/products/params/invoices_detail_products_params.dart';
import '../../data/api/invoices/find/entity/invoices_find_entity.dart';
import '../../data/api/invoices/find/params/invoices_find_params.dart';
import '../../data/api/invoices/list/entity/invoices_entity.dart';
import '../../data/api/invoices/list/params/invoices_list_params.dart';
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

  Future<ResetPasswordCodeEntity> forgotPassword(
      AuthForgotPasswordParams params);

  Future<void> resetPasswordCode(ResetPasswordCodeParams params);

  Future<ResetPasswordCodeEntity> resetPasswordWithCode(
      ResetPasswordWithCodeParams params);

  Future<void> logout();

  Future<ProfileInfoEntity> getProfile();

  Future<void> getProfileAct(ProfileActParams params);

  Future<ReceivablesInfoEntity> receivablesInfo();

  Future<InvoicesEntity> invoices(InvoicesListParams params);

  Future<InvoicesDetailEntity> invoicesDetail(InvoicesDetailParams params);

  Future<InvoicesDetailProductsEntity> invoicesDetailProducts(
    InvoicesDetailProductsParams params,
  );

  Future<ClaimsEntity> claims(ClaimsParams params);

  Future<InvoicesFindEntity> invoicesSearch(InvoicesFindParams params);

  Future<SearchClaimsEntity> claimsSearch(SearchClaimsParams params);

  Future<ClaimDetailEntity> claimsDetail(String uuid);

  Future<ClaimsDetailProductsEntity> claimsDetailProducts(String uuid);

  Future<ClaimDraftsListEntity> claimDraftsList(ClaimDraftsListParams params);

  Future<void> claimDraftsDelete(int uuid);

  Future<ClaimDraftsInfoEntity> claimDraftsInfo(int id);

  Future<ClaimDraftsProductsEntity> claimDraftProducts(
      int id, ClaimDraftsProductsParams params);

  Future<ClaimDraftsSendEntity> claimDraftSend(int id);

  Future<dynamic> claimDraftsSave(
    int id,
    ClaimDraftsSaveParams params,
  );

  Future<ClaimDraftsAddProductsEntity> claimDraftsAddProducts(int id);

  Future<void> claimDraftsDeleteProducts({
    required int id,
    required ClaimDraftsDeleteProductsParams params,
  });

  Future<ClaimDraftCreateEntity> claimDraftsCreate(
      ClaimDraftsCreateParams params);
}

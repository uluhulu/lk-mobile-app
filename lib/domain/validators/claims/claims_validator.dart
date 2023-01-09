import '../../../data/api/claim_drafts/list/params/claim_drafts_list_params.dart';
import '../../../data/api/claims/main/params/claims_params.dart';
import '../../enums/claims/claims_search_type.dart';

class ClaimsValidator {
  static String? validateSearchType(ClaimsSearchType? value) {
    if (value == null) {
      return null;
    }
    return null;
  }

  static String? validateSort(ClaimDraftsListSorting? value) {
    if (value == null) {
      return null;
    }
    return null;
  }

  static String? validateSortClaim(ClaimsSorting? value) {
    if (value == null) {
      return null;
    }
    return null;
  }
}

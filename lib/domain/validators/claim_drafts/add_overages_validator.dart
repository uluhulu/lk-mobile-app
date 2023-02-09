import '../../../data/api/claim_draft_overages/find_overages/entity/claim_drafts_find_overages_entity.dart';

class AddOveragesValidator {
  static String? productValidation(ClaimDraftFindOverageData? value) {
    if (value == null) {
      return 'Выберите товар';
    }
    return null;
  }

  static String? seriesValidation(OverageSeries? value) {
    if (value == null) {
      return 'Выберите серию';
    }
    return null;
  }
}

import '../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';

class ClaimDraftsValidator {
  static String? quantityClaim(String? value, int max,
      [bool? isError, String? claimType]) {
    final intValue = int.tryParse(value ?? '') ?? 0;
    if (claimType != null && claimType == 'Излишки') {
      if (intValue > max) {
        return null;
      }
      return null;
    }
    if (isError != null) {
      if (intValue > max || intValue == 0) {
        return 'Количество в претензии не должно быть больше $max';
      }
      return null;
    }
    if (intValue > max) {
      return 'Количество в претензии не должно быть больше $max';
    }
    return null;
  }

  static String? claimType(InvoicesDetailProductData? value) {
    if (value == null) {
      return 'Выберите товар';
    }
    return null;
  }

  static String? addProductClaimType(ClaimDraftsProductsData? value) {
    if (value == null) {
      return 'Выберите товар';
    }
    return null;
  }

  static String? claimTypeWithDrafts(String? value) {
    if (value == 'error') {
      return 'error';
    }
    return null;
  }

  static String? search(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return null;
  }
}

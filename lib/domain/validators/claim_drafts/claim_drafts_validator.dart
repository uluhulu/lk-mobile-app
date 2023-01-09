import '../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';

class ClaimDraftsValidator {
  static String? quantityClaim(String? value) {
    if (value == null || value.isEmpty) {
      return null;
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
    if (value == null || value.isEmpty) {
      return 'Выберите товар';
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

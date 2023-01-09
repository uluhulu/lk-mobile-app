import '../../../data/api/invoices/list/entity/invoices_entity.dart';
import '../../../data/api/invoices/list/params/invoices_list_params.dart';
import '../../enums/invoices/invoices_marked_type.dart';
import '../../enums/invoices/invoices_search_type.dart';

class InvoicesValidator {
  static String? validateSearch(String? value) {
    if (value == null || value.length < 3) {
      return '';
    }
    return null;
  }

  static String? validateDateFrom(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return null;
  }

  static String? validateAddress(Addresses? value) {
    if (value == null) {
      return 'Не выбрано';
    }
    return null;
  }

  static String? validateMarked(InvoicesMarkedType? value) {
    if (value == null) {
      return 'Не выбрано';
    }
    return null;
  }

  static String? validateMarkedStatus(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return null;
  }

  static String? validateStatusMark(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    return null;
  }

  static String? validateSearchType(InvoicesSearchType? value) {
    if (value == null) {
      return null;
    }
    return null;
  }

  static String? validateSort(InvoicesSorting? value) {
    if (value == null) {
      return null;
    }
    return null;
  }
}

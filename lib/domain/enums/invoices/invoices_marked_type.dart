enum InvoicesMarkedType {
  none,
  contains,
  notContains,
}

extension InvoicesMarkedTypeX on InvoicesMarkedType {
  String get name {
    switch (this) {
      case InvoicesMarkedType.none:
        return 'Не выбрано';
      case InvoicesMarkedType.contains:
        return 'Есть маркированный товар';
      case InvoicesMarkedType.notContains:
        return 'Нет маркированного товара';
    }
  }
}

class InvoicesMarkedTypeParser {
  static bool? isMarking(InvoicesMarkedType type) {
    switch (type) {
      case InvoicesMarkedType.contains:
        return true;
      case InvoicesMarkedType.notContains:
        return false;
      case InvoicesMarkedType.none:
        return null;
      default:
        return null;
    }
  }
}

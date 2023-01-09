import 'package:intl/intl.dart';

class Formatter {
  const Formatter();

  static String asCurrencyNum(num? amount, [int? decimalDigits]) {
    final NumberFormat format = NumberFormat.currency(
      locale: 'ru_RU',
      symbol: '₽',
      decimalDigits: decimalDigits ?? 2,
    );

    return amount != null ? format.format(amount).replaceAll(',', '.') : "-";
  }

  static String asCurrency(String? amount, [int? decimalDigits]) {
    // amount to double
    final double? amountDouble = double.tryParse(amount ?? '0');
    final NumberFormat format = NumberFormat.currency(
      locale: 'ru_RU',
      symbol: '₽',
      decimalDigits: decimalDigits ?? 2,
    );

    return amountDouble != null
        ? format.format(amountDouble).replaceAll(',', '.')
        : "-";
  }
}

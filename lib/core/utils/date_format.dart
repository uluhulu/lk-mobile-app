import 'package:intl/intl.dart';

class DateFormats {
  static String ddMMyyyy(DateTime? date) {
    if (date == null) {
      return "-";
    } else {
      return DateFormat('dd.MM.yyyy').format(date.toLocal());
    }
  }

  static String yyyyMMdd(DateTime? date) {
    if (date == null) {
      return "-";
    } else {
      return DateFormat('yyyy-MM-dd').format(date);
    }
  }

  static String isoDateFormatter(String? date) {
    if (date == null) {
      return "-";
    } else {
      return DateFormat('dd.MM.yyyy').format(DateTime.parse(date));
    }
  }
}

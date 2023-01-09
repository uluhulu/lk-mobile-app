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

  static String yyyyMMddWithString(String? date) {
    if (date == null) {
      return "-";
    } else {
      return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
    }
  }

  static String isoDateFormatter(String? date) {
    if (date == null) {
      return "-";
    } else {
      return DateFormat('dd.MM.yyyy').format(DateTime.parse(date));
    }
  }

  static String isoDateFormatterT(String? date) {
    if (date == null) {
      return "-";
    } else {
      return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
    }
  }

  static String isoDateTimeFormatter(String? date) {
    if (date == null) {
      return "-";
    } else {
      return DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(date));
    }
  }

  static String isoDateTimeFormatterWithUTC(String? date) {
    if (date == null) {
      return "-";
    } else {
      final utc = date.split('+');
      final utcLast = utc.last.split(':');

      return DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(date)
          .toUtc()
          .add(Duration(hours: int.parse(utcLast.first))));
    }
  }
}

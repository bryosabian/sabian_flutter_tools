import 'package:intl/intl.dart';

extension SabianDateFormats on DateTime {
  String toFormattedString(String pattern) {
    DateFormat format = DateFormat(pattern);
    return format.format(this);
  }
}

extension SabianStringDate on String {
  DateTime toDate(String? pattern) {
    if (pattern == null) {
      return DateTime.parse(this);
    }
    DateFormat format = DateFormat(pattern);
    return format.parse(this);
  }

  DateTime? toDateOrNull(String? pattern) {
    try {
      return toDate(pattern);
    } catch (e) {
      return null;
    }
  }
}

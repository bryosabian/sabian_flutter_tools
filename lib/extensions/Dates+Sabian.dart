import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension SabianDateExtension on DateTime {
  String toFormattedString(String pattern) {
    DateFormat format = DateFormat(pattern);
    return format.format(this);
  }

  DateTime toJustDate() {
    return DateUtils.dateOnly(this);
  }
}

extension SabianStringDate on String {
  DateTime toDate([String? pattern]) {
    if (pattern == null) {
      return DateTime.parse(this);
    }
    DateFormat format = DateFormat(pattern);
    return format.parse(this);
  }

  DateTime? toDateOrNull([String? pattern]) {
    try {
      return toDate(pattern);
    } catch (e) {
      return null;
    }
  }
}

extension DateTimeComparison on DateTime {
  bool isSameDayAs(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

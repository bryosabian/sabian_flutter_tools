import 'package:sprintf/sprintf.dart';

extension SabianNonNullStringExtension on String {
  String format(var args) => sprintf(this, args);
}

extension SabianNullableStringExtension on String? {

  bool get isBlankOrEmpty =>
      (this == null) ? true : (this!.isEmpty || this!.trim().isEmpty);

  bool get isNotBlankOrEmpty => !isBlankOrEmpty;

  bool isAMatchByKeyWord(String? keyWord, {bool reverseCheck = false}) {
    if (this == null || keyWord == null) {
      return false;
    }
    final regex = RegExp(r'.*' + keyWord + '.*', caseSensitive: false);
    if (!regex.hasMatch(this!)) {
      if (reverseCheck) {
        return keyWord.isAMatchByKeyWord(this, reverseCheck: false);
      }
      return false;
    }
    return true;
  }
}

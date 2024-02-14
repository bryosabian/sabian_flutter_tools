import 'dart:convert';

import 'package:sabian_tools/utils/utils.dart';
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
    //List<String> m = [];
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

extension SabianJson on String {
  List<T> fromJsonToList<T>(T Function(Map<String, dynamic>) onMap) {
    List<dynamic> list = jsonDecode(this);
    List<T> responses = list
        .map((e) => onMap(e as Map<String, dynamic>))
        .toList(growable: false);
    return responses;
  }

  List<T>? fromJsonToListOrNull<T>(T Function(Map<String, dynamic>) onMap) {
    try {
      return fromJsonToList(onMap);
    } catch (e) {
      sabianPrint("Could not convert json $e");
      return null;
    }
  }

  T fromJson<T>(T Function(Map<String, dynamic>) onMap) {
    Map<String, dynamic> data = jsonDecode(this);
    T mData = onMap(data);
    return mData;
  }

  T? fromJsonOrNull<T>(T Function(Map<String, dynamic>) onMap) {
    try {
      return fromJson(onMap);
    } catch (e) {
      sabianPrint("Could not convert json $e");
      return null;
    }
  }
}

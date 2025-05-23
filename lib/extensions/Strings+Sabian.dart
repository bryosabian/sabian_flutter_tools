import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sabian_tools/utils/utils.dart';
import 'package:sprintf/sprintf.dart';

extension SabianNonNullStringExtension on String {
  String format(var args) {
    dynamic mArgs = [];
    if (args is! List) {
      mArgs = [args];
    } else {
      mArgs = args;
    }
    return sprintf(this, mArgs);
  }
}

extension SabianNullableStringExtension on String? {
  bool get isBlankOrEmpty =>
      (this == null) ? true : (this!.isEmpty || this!.trim().isEmpty);

  bool get isNotBlankOrEmpty => !isBlankOrEmpty;
}

extension SabianRegexShortcutsNullable on String? {
  /// e.g Gets literal value from literal key.value e.t.c.
  ///
  /// Must be joined by dot operator (.)
  String? getValueFromDotKey({String prepend = "key", String dot = "."}) {
    if (this == null) return null;
    if (this!.isEmpty) return null;
    final regex = "(${prepend}\\$dot)(.*)";
    final pattern = RegExp(regex, caseSensitive: false);
    final match = pattern.firstMatch(this!);
    if (match != null) {
      try {
        return match.group(2);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

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


  /// Checks if the string matches any of the provided keywords.
  ///
  /// [keyWords]: A list of strings to check against.
  /// [reverseLook]: If true, also checks if any keyword is a match by this string.
  /// Returns true if a match is found, false otherwise.
  bool matchesWithAnyKeyWord(List<String> keyWords, {bool reverseLook = false}) {
    if (keyWords.isEmpty) {
      return false;
    }
    return keyWords.any((keyword) {
      // Assuming 'this.isAMatchByKeyWord(keyword)' is available.
      // 'this' refers to the string instance on which matchesWithAnyKeyWord is called.
      bool primaryMatch = this.isAMatchByKeyWord(keyword);
      if (primaryMatch) {
        return true;
      }
      if (reverseLook) {
        // Assuming 'keyword.isAMatchByKeyWord(this)' is available.
        return keyword.isAMatchByKeyWord(this);
      }
      return false;
    });
  }


  String get noWhiteSpaces {
    String _this = this ?? "";
    return _this.replaceAll(RegExp(r'\s+'), '');
  }

  String get noDoubleSpaces {
    String _this = this ?? "";
    return _this.replaceAll(RegExp(r'\s{2,}'), ' ');
  }

  static String get _SPECIAL_CHARACTERS_REGEX =>
      r"[<>\/{}%()\[\].+*?^$\|\@\#\:]";

  String escapeSpecialRegexChars() {
    return this!.replaceAllMapped(
        RegExp(_SPECIAL_CHARACTERS_REGEX), (match) => '\\${match.group(0)}');
  }

  String replaceSpecialRegexChars({String replacement = ""}) {
    return this!.replaceAll(RegExp(_SPECIAL_CHARACTERS_REGEX), replacement);
  }
}

extension SabianJson on String {
  List<T> fromJsonToList<T>(T Function(Map<String, dynamic>) onMap,
      {bool growable = true}) {
    List<dynamic> list = jsonDecode(this);
    List<T> responses = list
        .map((e) => onMap(e as Map<String, dynamic>))
        .toList(growable: growable);
    return responses;
  }

  List<T>? fromJsonToListOrNull<T>(T Function(Map<String, dynamic>) onMap,
      {bool growable = true}) {
    try {
      return fromJsonToList(onMap, growable: growable);
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

  List<T> fromJsonToDirectList<T>(T Function(dynamic) onMap,
      {bool growable = true}) {
    List<dynamic> list = jsonDecode(this);
    List<T> responses = list.map((e) => onMap(e)).toList(growable: growable);
    return responses;
  }

  List<T>? fromJsonToDirectListOrNull<T>(T Function(dynamic) onMap,
      {bool growable = true}) {
    try {
      return fromJsonToDirectList(onMap, growable: growable);
    } catch (e) {
      sabianPrint("Could not convert json $e");
      return null;
    }
  }

  T fromDirectJson<T>(T Function(dynamic) onMap) {
    dynamic data = jsonDecode(this);
    T mData = onMap(data);
    return mData;
  }

  T? fromDirectJsonOrNull<T>(T Function(dynamic) onMap) {
    try {
      return fromDirectJson(onMap);
    } catch (e) {
      sabianPrint("Could not convert json $e");
      return null;
    }
  }
}

extension BlankCheck on String {
  String ifBlank(String Function() defaultValue) {
    if (isNotBlankOrEmpty) {
      return this;
    }
    return defaultValue();
  }

  String ifEmpty(String Function() defaultValue) {
    if (isNotEmpty) {
      return this;
    }
    return defaultValue();
  }
}

extension BlankCheckNullable on String? {
  String ifNullOrBlank(String Function() defaultValue) {
    return this?.ifBlank(defaultValue) ?? defaultValue();
  }

  String ifNullOrEmpty(String Function() defaultValue) {
    return this?.ifEmpty(defaultValue) ?? defaultValue();
  }
}

extension StringBytes on String {
  List<int> get toBytes {
    return utf8.encode(this);
  }
}

extension KeyExtensions on String {
  Key get toKey => Key(this);
}

extension Manipulation on String {
  String perfectCase({bool considerSpaces = true}) {
    if (!considerSpaces) {
      return toLowerCase().replaceFirstMapped(
          RegExp(r'[a-z]'), (match) => match.group(0)!.toUpperCase());
    }
    final all = split(RegExp(r'\s+'));
    return all.map((it) => it.perfectCase(considerSpaces: false)).join(' ');
  }

  String perfectForm() {
    return trim().noDoubleSpaces.perfectCase();
  }

  String get toBase64 {
    return base64Encode(utf8.encode(this));
  }

}

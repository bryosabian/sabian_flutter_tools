import 'dart:collection';

import 'package:flutter/foundation.dart';

abstract class Logger {
  void log(String message);
}

class DebugLogger extends Logger {
  @override
  void log(String message) {
    if (kDebugMode) {
      print(message);
    }
  }
}

class MainLogger extends DebugLogger {}

class Loggers {
  late Map<String, Logger> loggers;

  static Loggers? _instance;

  Loggers._createNew() {
    loggers = HashMap();
    loggers["debug"] = DebugLogger();
    loggers["main"] = MainLogger();
  }

  Logger get current => (kDebugMode) ? loggers["debug"]! : loggers["main"]!;

  factory Loggers() {
    _instance ??= Loggers._createNew();
    return _instance!;
  }
}

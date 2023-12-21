import 'package:sabian_tools/extensions/Strings+Sabian.dart';

class SabianException implements Exception {

  String cause;

  String? title;

  int? code;

  Exception? throwable;

  SabianException(this.cause, {this.code, this.title});

  factory SabianException.fromObject(Object? cause, {int? code, String? title}){
    SabianException exception = SabianException("Unknown");
    exception.cause = cause?.toString() ?? "Unknown";
    if (cause is Exception) {
      exception.throwable = cause;
    }
    return exception;
  }

  @override
  String toString() {
    return "cause : %s code : %s".format(
        [cause, code?.toString() ?? "Unknown"]);
  }
}

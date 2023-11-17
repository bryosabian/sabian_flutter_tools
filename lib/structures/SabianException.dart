import 'package:sabian_tools/extensions/Strings+Sabian.dart';

class SabianException implements Exception {

  String cause;

  String? title;

  int? code;

  SabianException(this.cause, {this.code,this.title});

  @override
  String toString() {
    return "cause : %s code : %s".format([cause,code?.toString() ?? "Unknown"]);
  }
}

import 'package:sabian_tools/extensions/SabianException+Error.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';

class SabianException implements Exception {
  String cause;

  String? title;

  int? code;

  Exception? throwable;

  dynamic source;

  static const String CAUSE_UNKNOWN = "Unknown error";

  static const String CAUSE_INTERNAL = "Internal error";

  static bool canReportInternalErrors = false;

  SabianException(this.cause, {this.code, this.title});

  factory SabianException.fromDynamic(dynamic cause,
      {int? code, String? title}) {
    SabianException exception;
    if (cause is Exception) {
      exception = cause.toSabianException;
    } else if (cause is Error) {
      exception = cause.toSabianException;
    } else {
      exception = SabianException(CAUSE_INTERNAL);
    }
    if (title?.isNotBlankOrEmpty ?? false) {
      exception.title = title;
    }
    if (code != null) {
      exception.code = code;
    }
    return exception;
  }

  factory SabianException.fromObject(Object? cause,
      {int? code, String? title}) {
    SabianException exception;
    if (cause is Exception) {
      exception = cause.toSabianException;
    } else if (cause is Error) {
      exception = (cause).toSabianException;
    } else {
      exception = SabianException(CAUSE_INTERNAL);
      exception.cause = cause?.toString() ?? CAUSE_UNKNOWN;
    }
    if (title?.isNotBlankOrEmpty ?? false) {
      exception.title = title;
    }
    if (code != null) {
      exception.code = code;
    }
    return exception;
  }

  factory SabianException.copyOf(SabianException e) {
    SabianException se = SabianException(e.cause, title: e.title, code: e.code);
    se.source = e.source;
    se.throwable = e.throwable;
    return se;
  }

  @override
  String toString() {
    return "cause : %s code : %s"
        .format([cause, code?.toString() ?? "Unknown"]);
  }

  String get message => toReadableString();

  String toReadableString({bool? includeTitle = false}) {
    List<String> builder = [];
    if (includeTitle == true) builder.add(title.ifNullOrBlank(() => "Error"));
    builder.add(cause.ifNullOrBlank(() => CAUSE_UNKNOWN));
    return builder.join(" ");
  }
}

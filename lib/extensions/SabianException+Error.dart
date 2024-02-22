import 'package:sabian_tools/extensions/Strings+Sabian.dart';
import 'package:sabian_tools/structures/SabianException.dart';

extension ErrorToSabianException on Error {
  SabianException get toSabianException {
    if (this is SabianException) {
      return this as SabianException;
    }
    String cause = SabianException.CAUSE_INTERNAL;
    Exception e = Exception(this);
    return SabianException(cause)
      ..throwable = e
      ..source = this;
  }
}

extension ExceptionToSabianException on Exception {
  SabianException get toSabianException {
    if (this is SabianException) {
      return this as SabianException;
    }
    String cause =
        toString().ifNullOrBlank(() => SabianException.CAUSE_UNKNOWN);
    return SabianException(cause)
      ..throwable = this
      ..source = this;
  }
}

import 'dart:async';
import 'dart:math';

import 'package:sabian_tools/utils/Logger.dart';

void sabianPrint(Object message) {
  Loggers().current.log(message.toString());
}

Timer sabianStartCountDown(int maxSeconds, Function() onFinished) {
  const oneSec = Duration(seconds: 1);
  return Timer.periodic(
    oneSec,
        (Timer timer) {
      if (timer.tick >= maxSeconds) {
        onFinished.call();
        timer.cancel();
      }
    },
  );
}

String sabianGetRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

int get sabianUniqueID =>
    DateTime
        .now()
        .millisecondsSinceEpoch;

import 'dart:async';
import 'dart:math';

import 'package:sabian_tools/utils/Logger.dart';
import 'package:uuid/uuid.dart';

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

import 'dart:math';

import 'package:uuid/uuid.dart';

String sabianGetRandomString(int len) {
  var r = Random();
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

String get sabianUniqueId {
  const uuid = Uuid();
  return uuid.v4();
}
import 'dart:convert';

extension SabianObjectsAndExtras on Object {
  String get toJson {
    return jsonEncode(this);
  }
}

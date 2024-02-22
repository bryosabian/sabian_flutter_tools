import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_tools/extensions/SabianException+Error.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';
import 'package:sabian_tools/structures/SabianException.dart';
import 'package:sabian_tools/utils/utils.dart';

void main() {
  test("Is a match extension returns expected results", () {
    dynamic error;
    SabianException? se;
    double m;
    try {
      m = 2 / 0;
      if (m == double.infinity) {
        throw SabianException("This is just so wrong", title: "Division Error");
      }
    } catch (e) {
      error = e;
    }
    bool success = false;
    try {
      if (error != null) {
        se = SabianException.fromDynamic(error);
        success = true;
      }
    } catch (e) {
      success = false;
    }
    assert(se?.message.isNotBlankOrEmpty ?? false);
    sabianPrint(se!.message);
    assert(success);
  });
}

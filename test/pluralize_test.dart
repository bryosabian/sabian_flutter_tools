import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_tools/utils/pluralize.dart';

void main() {
  test("Pluralizer works as expected", () {
    var plural = "person".pluralize();
    assert(plural == "people");

    plural = "mouse".pluralize();
    assert(plural == "mice");

    plural = "seat".pluralize();
    assert(plural == "seats");
  });
}

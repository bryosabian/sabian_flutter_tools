import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';

void main() {
  test("Is a match extension returns expected results", () {
    String value = "Brian is the most awesome Person in the world";
    String keyWord = "person";
    assert(value.isAMatchByKeyWord(keyWord));
  });

  test("Is a match extension returns false when not in reverse", () {
    String value = "Person";
    String keyWord = "Brian is an awesome person";
    assert(!value.isAMatchByKeyWord(keyWord));
  });

  test("Is a match extension returns true when in reverse", () {
    String value = "Person";
    String keyWord = "Brian is an awesome person";
    assert(value.isAMatchByKeyWord(keyWord,reverseCheck: true));
  });
}

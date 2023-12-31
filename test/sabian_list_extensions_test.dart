import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_tools/extensions/Lists+Sabian.dart';

void main() {
  test("list conversion from string works", () {
    String jsonList = '["A","B","C","D"]';
    List<String> list = jsonList.toPrimitiveList<String>();
    assert(list.isNotEmpty && list.length == 4);
  });

  test("list conversion from int works", () {
    String jsonList = '[1,2,3,4]';
    List<int> list = jsonList.toPrimitiveList<int>();
    assert(list.isNotEmpty && list.length == 4);
    int total = list.reduce((value, element) => value + element);
    assert(total == 10);
  });

  test("list conversion to ordered set works", () {
    List<int> originalList = [1, 2, 3, 3, 4, 5, 6, 6, 7];
    assert(originalList.length == 9);
    Set<int> orderedSet = originalList.toOrderedSet();
    assert(orderedSet.length == 7);
    List<int> orderedList = orderedSet.toList(growable: false);
    assert(orderedList.first == 1 && orderedList.last == 7);
  });

  test("list item returns null if index out of range and does not throw", () {
    List<String> items = ["Jared", "Leto", "Sabian"];
    String? search = items.get(0);
    assert(search != null && search == "Jared");
    search = items.get(3);
    assert(search == null);
  });
}

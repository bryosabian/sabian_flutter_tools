import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_tools/extensions/Lists+Sabian.dart';

import 'TestSubject.dart';

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

  test("list item returns null if not found", () {
    List<String> items = ["Jared", "Leto", "Sabian"];
    String search = "Jared";
    String? searched = items.firstWhereOrNull((element) => element == search);
    assert(searched != null);

    searched = items.firstWhereOrNull((p0) => p0 == "No name");
    assert(searched == null);
  });

  test("mapped by association works", () {
    List<TestSubject> subjects = [
      TestSubject("Jared", "He's awesome", 101),
      TestSubject("Lisa", "She's beautiful", 102),
      TestSubject("Sarah", "She's charming", 102)
    ];

    Map<int, TestSubject> mapped = subjects.mappedBy((p0) => p0.ID!);
    assert(mapped.length == 2);
    assert(mapped[102] != null && mapped[102]!.name == "Sarah");
  });

  test("where not null works", () {
    List<TestSubject> numbers = [
      TestSubject("Jared", "Lisa", 101),
      TestSubject("Sarah", null, null)
    ];
    final valid =
        numbers.whereNotNull((e) => e.description).toList(growable: false);
    assert(valid.length == 1);

    final mapped = numbers.mapNotNull((e) => e.description);
    assert(mapped.length == 1 && mapped.first == "Lisa");
  });

  test("list group by works", () {
    int id = 100;
    List<TestSubject> subject = [
      TestSubject("Jared", "Lisa", id++, age: 20),
      TestSubject("Sarah", "Hassan", id++, age: 20),
      TestSubject("Mike", "Posner", id++, age: 20),
      TestSubject("Fred", "Mike", id++, age: 20),
      TestSubject("Lisa", "Orio", id++, age: 23),
      TestSubject("Sally", "Mike", id++, age: 23)
    ];
    final grouped = subject.groupedBy((e) => e.age);
    assert(grouped.length == 2);
    assert(grouped[20] != null && grouped[20]!.length == 4);
    assert(grouped[23] != null && grouped[23]!.length == 2);
  });
}

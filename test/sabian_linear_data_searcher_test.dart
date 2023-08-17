import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_tools/utils/tasks/SabianLinearDataSearcher.dart';

void main() {
  List<_TestSubject> _getSubjects() {
    List<_TestSubject> subjects = [];
    subjects.add(_TestSubject("Brian", "The best boy", 123));
    subjects.add(_TestSubject("Lisa", "The best girl", 123));
    subjects.add(_TestSubject("Sarah", "The worst girl", 123));
    return subjects;
  }

  test('linear data searcher can search by key words', () {
    List<_TestSubject> subjects = _getSubjects();

    SabianLinearDataSearcher<_TestSubject> searcher =
        SabianLinearDataSearcher.withOutCallBacks(
            searchCriteria: (s) => [s.description]);
    List<_TestSubject> best_search = searcher.directSearch(subjects, "best");
    assert(best_search.length == 2);
    assert(!best_search.contains(_TestSubject.name("Sarah")));

    List<_TestSubject> girls = searcher.directSearch(subjects, "girl");
    assert(girls.length == 2);
    assert(!girls.contains(_TestSubject.name("Brian")));
  });

  test('linear data searcher can search by key words async', () async {
    List<_TestSubject> subjects = _getSubjects();

    SabianLinearDataSearcher<_TestSubject> searcher = SabianLinearDataSearcher(
        onSearched: (best_search) {
          assert(best_search.length == 2);
          assert(!best_search.contains(_TestSubject.name("Sarah")));
        },
        searchCriteria: (subject) => [subject.description]);

    searcher.search(subjects, "best");

    await Future.delayed(const Duration(seconds: 5));
  });
}

class _TestSubject {
  String name;
  String description;
  int value;

  _TestSubject(this.name, this.description, this.value);

  _TestSubject.name(this.name, {this.description = "", this.value = 0});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _TestSubject &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

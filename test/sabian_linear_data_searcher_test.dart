import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_tools/utils/tasks/SabianLinearDataSearcher.dart';

import 'TestSubject.dart';

void main() {
  List<TestSubject> _getSubjects() {
    List<TestSubject> subjects = [];
    subjects.add(TestSubject("Brian", "The best boy", 123));
    subjects.add(TestSubject("Lisa", "The best girl", 123));
    subjects.add(TestSubject("Sarah", "The worst girl", 123));
    return subjects;
  }

  test('linear data searcher can search by key words', () {
    List<TestSubject> subjects = _getSubjects();

    SabianLinearDataSearcher<TestSubject> searcher =
        SabianLinearDataSearcher.withOutCallBacks(
            searchCriteria: (s) => [s.description]);
    List<TestSubject> best_search = searcher.directSearch(subjects, "best");
    assert(best_search.length == 2);
    assert(!best_search.contains(TestSubject.name("Sarah")));

    List<TestSubject> girls = searcher.directSearch(subjects, "girl");
    assert(girls.length == 2);
    assert(!girls.contains(TestSubject.name("Brian")));
  });

  test('linear data searcher can search by key words async', () async {
    List<TestSubject> subjects = _getSubjects();

    SabianLinearDataSearcher<TestSubject> searcher = SabianLinearDataSearcher(
        onSearched: (bestSearch) {
          assert(bestSearch.length == 2);
          assert(!bestSearch.contains(TestSubject.name("Sarah")));
        },
        searchCriteria: (subject) => [subject.description]);

    searcher.search(subjects, "best");

    await Future.delayed(const Duration(seconds: 5));
  });
}



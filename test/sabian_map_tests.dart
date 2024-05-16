import 'package:flutter_test/flutter_test.dart';
import 'package:sabian_tools/extensions/Maps+Sabian.dart';

void main() {
  group('Map extras test', () {
    test('test filterByValue works', () {
      var map = {1: 'one', 2: 'two', 3: 'three'};
      var result = map.filterByValue((value) => value.startsWith('t'));
      expect(result, {2: 'two', 3: 'three'});
    });

    test('test filterByKey works', () {
      var map = {1: 'one', 2: 'two', 3: 'three'};
      var result = map.filterByKey((key) => key > 1);
      expect(result, {2: 'two', 3: 'three'});
    });

    test('test filter works', () {
      var map = {1: 'one', 2: 'two', 3: 'three'};
      var result = map.filter((value, key) => value.startsWith('t') && key > 1);
      expect(result, {2: 'two', 3: 'three'});
    });

    test('test map sorted by key works', () {
      var map = {3: 'three', 1: 'one', 2: 'two'};
      var result = map.sorted((a, b) => a.key.compareTo(b.key));
      expect(result, {1: 'one', 2: 'two', 3: 'three'});
    });

    test('test map sorted by value works', () {
      var map = {'three': 3, 'two': 2, 'one': 1, 'ten': 10};
      var result = map.sorted((a, b) => a.value.compareTo(b.value));
      expect(result, {'one': 1, 'two': 2, 'three': 3, 'ten': 10});
    });
  });
}

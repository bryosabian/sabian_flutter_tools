import 'dart:collection';

extension MapExras<K, V> on Map<K, V> {
  Map<K, V> filterByValue(bool Function(V) predicate) {
    LinkedHashMap<K, V> map = LinkedHashMap();
    for (var key in keys) {
      if (predicate(this[key]!)) {
        map[key] = this[key]!;
      }
    }
    return map;
  }

  Map<K, V> filterByKey(bool Function(K) predicate) {
    LinkedHashMap<K, V> map = LinkedHashMap();
    for (var key in keys) {
      if (predicate(key)) {
        map[key] = this[key]!;
      }
    }
    return map;
  }

  Map<K, V> filter(bool Function(V, K) predicate) {
    LinkedHashMap<K, V> map = LinkedHashMap();
    for (var key in keys) {
      if (predicate(this[key]!, key)) {
        map[key] = this[key]!;
      }
    }
    return map;
  }

  Map<K, V> sorted(
      int Function(MapEntry<K, V> a, MapEntry<K, V> b) comparator) {
    LinkedHashMap<K, V> map = LinkedHashMap();
    var keys = this.keys.toList();
    keys.sort(
        (a, b) => comparator(MapEntry(a, this[a]!), MapEntry(b, this[b]!)));
    for (var key in keys) {
      map[key] = this[key]!;
    }
    return map;
  }
}

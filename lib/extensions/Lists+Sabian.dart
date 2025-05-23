import 'dart:collection';
import 'dart:convert';

import 'package:sabian_tools/structures/SabianException.dart';

extension SabianListDeserializer on String {
  List<E> toPrimitiveList<E>() {
    List<E> mList = (jsonDecode(this) as List<dynamic>).cast<E>();
    return mList;
  }
}

extension SabianListModifier<E> on Iterable<E> {
  LinkedHashSet<E> toOrderedSet() {
    LinkedHashSet<E> set = LinkedHashSet();
    for (var e in this) {
      set.add(e);
    }
    return set;
  }

  List<E> distinct() {
    return toOrderedSet().toList();
  }

  /// Gets element at index or returns null if not found.
  /// Useful when you just want to get an object or null instead of catching errors
  E? elementAtOrNull(int index) {
    try {
      return elementAt(index);
    } on Error {
      return null;
    }
  }
}

extension SabianListItem<E> on Iterable<E> {
  /// Gets element at index or returns null if not found.
  /// Useful when you just want to get an object or null instead of catching errors
  E? get(int index) {
    return elementAtOrNull(index);
  }

  /// Gets element at index or returns null if not found.
  /// Useful when you just want to get an object or null instead of catching errors
  E? firstWhereOrNull(bool Function(E) predicate) {
    try {
      return firstWhere(predicate);
    } on Error {
      return null;
    }
  }
}

extension SabianListPosition<E> on List<E> {
  ///Whether object is last
  bool isLast(E object) {
    return isIndexLast(indexOf(object));
  }

  ///Whether object is first
  bool isFirst(E object) {
    return indexOf(object) == 0;
  }

  ///Whether specified index is last
  bool isIndexLast(int index) {
    return index == length - 1;
  }
}

extension SabianSetPosition<E> on Set<E> {
  ///Whether object is last
  bool isLast(E object) {
    return isIndexLast(toList(growable: false).indexOf(object));
  }

  ///Whether object is first
  bool isFirst(E object) {
    return toList(growable: false).indexOf(object) == 0;
  }

  ///Whether specified index is last
  bool isIndexLast(int index) {
    return index == length - 1;
  }
}

extension SabianListConverter<E> on Iterable<E> {
  Map<K, E> mappedBy<K>(K Function(E) key) {
    final map = {for (E e in this) key(e): e};
    return map;
  }

  Map<K, List<E>> groupedBy<K>(K Function(E) key) {
    final Map<K, List<E>> map = {};
    for (E e in this) {
      final keyValue = key(e);
      final mapValue = map[keyValue] ?? [];
      mapValue.add(e);
      map[keyValue] = mapValue;
    }
    return map;
  }
}

extension SabianListMethods<E> on List<E> {
  List<List<E>> chunked(int size) {
    List<List<E>> chunks = [];
    for (int i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }

  void sortBy<T>(T Function(E) key) {
    sort((a, b) {
      final mA = key(a);
      final mB = key(b);
      if (mA is num && mB is num) {
        return mA.compareTo(mB);
      }
      if (mA is int && mB is int) {
        return mA.compareTo(mB);
      }
      if (mA is String && mB is String) {
        return mA.compareTo(mB);
      }
      if (mA is Comparable && mB is Comparable) {
        return mA.compareTo(mB);
      }
      throw SabianException(
          "Illegal comparables. Accepted are int, string,bool, or Comparable");
    });
  }

  void sortByDesc<T>(T Function(E) key) {
    sort((a, b) {
      final mA = key(b);
      final mB = key(a);
      if (mA is num && mB is num) {
        return mA.compareTo(mB);
      }
      if (mA is int && mB is int) {
        return mA.compareTo(mB);
      }
      if (mA is String && mB is String) {
        return mA.compareTo(mB);
      }
      if (mA is Comparable && mB is Comparable) {
        return mA.compareTo(mB);
      }
      throw SabianException(
          "Illegal comparable. Accepted are int, string or Comparable");
    });
  }
}

extension SabianListObjectItem on Object {
  List<T> collect<T>() {
    return [this as T];
  }
}

extension SabianIterableExtension<E> on Iterable<E> {
  Iterable<V> mappedByIndex<V>(V Function(E, int) caller) {
    return Iterable<int>.generate(length).map((idx) {
      return caller.call(elementAt(idx), idx);
    });
  }

  Iterable<E> whereNotNull([Object? Function(E)? test]) {
    return where((e) {
      if (test == null) {
        return e != null;
      }
      return test.call(e) != null;
    });
  }

  Iterable<V> mapNotNull<V>(V? Function(E) test) {
    return whereNotNull(test).map((e) => test.call(e)!);
  }
}

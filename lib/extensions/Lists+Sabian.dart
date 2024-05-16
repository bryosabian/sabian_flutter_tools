import 'dart:collection';
import 'dart:convert';

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

extension SabianListConverter<E> on Iterable<E> {
  Map<K, E> mappedBy<K>(K Function(E) key) {
    final map = {for (E e in this) key(e): e};
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
}

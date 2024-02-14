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

  /// Gets element at index or returns null if not found.
  /// Useful when you just want to get an object or null instead of catching errors
  E? elementAtOrNull(int index) {
    try {
      return elementAt(index);
    } on Error {
      return null;
    }
  }

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

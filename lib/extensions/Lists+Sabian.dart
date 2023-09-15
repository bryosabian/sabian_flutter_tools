import 'dart:convert';

extension SabianListDeserializer on String {
  List<E> toPrimitiveList<E>() {
    List<E> mList = (jsonDecode(this) as List<dynamic>).cast<E>();
    return mList;
  }
}

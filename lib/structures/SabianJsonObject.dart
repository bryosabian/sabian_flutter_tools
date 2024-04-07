mixin SabianJsonObject<T> {

  ///Converts a json map to an instance of the object
  /// Must be a qualified function and not getter so as to be jsonEncode compatible
  Map<String, dynamic> toJson();
}

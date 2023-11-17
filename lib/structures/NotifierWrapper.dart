import 'package:flutter/material.dart';

class NotifierWrapper<T> extends ChangeNotifier {
  T value;

  NotifierWrapper(this.value);

  void setValue(T newValue, {bool notify = true}) {
    value = newValue;
    notifyListeners();
  }
}

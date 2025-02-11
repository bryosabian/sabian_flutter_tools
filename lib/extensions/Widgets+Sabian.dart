import 'package:flutter/material.dart';

extension WidgetExtension<T extends StatefulWidget> on State<T> {

  @protected
  void setStateIfMounted(VoidCallback fn){
    if(mounted){
      setState(fn);
    }
  }
}
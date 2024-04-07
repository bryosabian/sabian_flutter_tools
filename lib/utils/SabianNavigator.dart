import 'package:flutter/material.dart';
import 'package:sabian_tools/modals/SabianPageTransition.dart';

@Deprecated("Use SabianPageNavigator instead")
class SabianNavigator {
  static SabianNavigator? _instance;

  SabianNavigator._internal();

  factory SabianNavigator.instance() {
    return _instance ??= SabianNavigator._internal();
  }

  void transit(BuildContext context, SabianPageTransition transition) {
    Navigator.push(
      context,
      transition.routeBuilder,
    );
  }

  void transitTo(BuildContext context,
      {required Widget page, required String transition}) {
    transit(context, SabianPageTransition(to: page, transition: transition));
  }

  void open(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void close<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  ///@deprecated. Use SabianModal instead
  @Deprecated("Use SabianModal instead")
  void openDialog(BuildContext context, Widget dialog) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }

  ///@deprecated. Use SabianModal instead
  @Deprecated("Use SabianModal instead")
  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}

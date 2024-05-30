import 'package:flutter/material.dart';
import 'package:sabian_tools/pages/SabianAnimatedPageNavigator.dart';

class SabianGlobalPageNavigator extends InheritedWidget {
  final SabianAnimatedPageNavigator? navigator;

  const SabianGlobalPageNavigator(
      {super.key, required super.child, this.navigator});

  static SabianGlobalPageNavigator? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SabianGlobalPageNavigator>();
  }

  @override
  bool updateShouldNotify(SabianGlobalPageNavigator oldWidget) {
    return false;
  }
}

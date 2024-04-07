import 'package:flutter/material.dart';
import 'package:sabian_tools/modals/SabianPageTransition.dart';
import 'package:sabian_tools/pages/SabianPageNavigator.dart';

typedef AnimatedPageTransitionBuilder = SabianPageTransition Function(
    Widget page);

class SabianAnimatedPageNavigator extends SabianPageNavigator<Widget> {
  final AnimatedPageTransitionBuilder? _transitionBuilder;
  final String _transition;

  SabianAnimatedPageNavigator(
      {AnimatedPageTransitionBuilder? transitionBuilder,
      String transition = "fade"})
      : _transitionBuilder = transitionBuilder,
        _transition = transition;

  SabianPageTransition _pageTransition(Widget page) {
    if (_transitionBuilder != null) {
      return _transitionBuilder!(page);
    }
    return SabianPageTransition(to: page, transition: _transition);
  }

  @override
  Route<Widget> buildRoute(BuildContext context,
      {bool fullscreenDialog = false,
      required Widget page,
      required bool maintainState}) {
    return _pageTransition(page).routeBuilder;
  }
}

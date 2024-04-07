import 'package:flutter/material.dart';
import 'package:sabian_tools/modals/Transitions.dart';

class SabianPageTransition<T extends Widget> {

  final Widget to;

  final String? transition;

  final Duration transitionDuration;

  final SabianModalTransition? customTransition;

  SabianModalTransition get _currentTransition =>
      customTransition ?? SabianModalTransition.get(transition);

  const SabianPageTransition(
      {required this.to,
      this.transition,
      this.transitionDuration = const Duration(milliseconds: 300),
      this.customTransition});

  PageRouteBuilder<T> get routeBuilder {
    return PageRouteBuilder<T>(
        pageBuilder: _getPage,
        transitionsBuilder: _getTransition,
        transitionDuration: transitionDuration,
        reverseTransitionDuration: transitionDuration);
  }

  Widget _getPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return to;
  }

  Widget _getTransition(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var transition = _currentTransition;
    Animation mAnim = transition.createAnimation(animation);
    return transition.getParent(animation: mAnim, child: child);
  }
}

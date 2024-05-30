import 'package:flutter/material.dart';
import 'package:sabian_tools/modals/SabianPageTransition.dart';
import 'package:sabian_tools/pages/SabianPageNavigator.dart';

typedef AnimatedPageTransitionBuilder = SabianPageTransition Function(
    Widget page);

class SabianAnimatedPageNavigator extends SabianPageNavigator<Widget> {
  static const defaultTransition = "slide_up";

  final AnimatedPageTransitionBuilder? _transitionBuilder;
  final String _transition;

  SabianAnimatedPageNavigator(
      {AnimatedPageTransitionBuilder? transitionBuilder,
      String transition = defaultTransition})
      : _transitionBuilder = transitionBuilder,
        _transition = transition;

  SabianPageTransition _pageTransition(Widget page,
      {String? transition, AnimatedPageTransitionBuilder? transitionBuilder}) {
    var _transitionBuilder = this._transitionBuilder;
    var _transition = this._transition;
    if (transitionBuilder != null) {
      _transitionBuilder = transitionBuilder;
    }
    if (transition != null) {
      _transition = transition;
    }
    if (_transitionBuilder != null) {
      return _transitionBuilder(page);
    }
    return SabianPageTransition(to: page, transition: _transition);
  }

  /// Shows the modal and returns the key to be tracked by route asynchronously
  Future<String> showAnimatedAsync(
      BuildContext context, String key, Widget page,
      {bool maintainState = false,
      bool fullscreenDialog = false,
      String transition = defaultTransition,
      AnimatedPageTransitionBuilder? transitionBuilder}) async {
    final Map<String, Object> extraParams = {
      "transition": transition,
    };
    if (transitionBuilder != null) {
      extraParams["transitionBuilder"] = transitionBuilder;
    }
    return showAsync(context, key, page,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        extraParams: extraParams);
  }

  /// Shows the modal and returns the key to be tracked by route
  String showAnimated(BuildContext context, String key, Widget page,
      {bool maintainState = false,
      bool fullscreenDialog = false,
      String transition = defaultTransition,
      AnimatedPageTransitionBuilder? transitionBuilder}) {
    final Map<String, Object> extraParams = {
      "transition": transition,
    };
    if (transitionBuilder != null) {
      extraParams["transitionBuilder"] = transitionBuilder;
    }
    return show(context, key, page,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        extraParams: extraParams);
  }

  ///Hides all routes and shows
  void hideAllAndShowAnimated(BuildContext context, Widget page,
      {String? key,
      String transition = defaultTransition,
      AnimatedPageTransitionBuilder? transitionBuilder}) {
    final Map<String, Object> extraParams = {
      "transition": transition,
    };
    if (transitionBuilder != null) {
      extraParams["transitionBuilder"] = transitionBuilder;
    }

    return hideAllAndShow(context, page, extraParams: extraParams);
  }

  @override
  Route<Widget> buildRoute(BuildContext context,
      {bool fullscreenDialog = false,
      required Widget page,
      required bool maintainState,
      Map<String, Object>? extraParams}) {
    String? transition;
    AnimatedPageTransitionBuilder? transitionBuilder;
    if (extraParams != null) {
      if (extraParams["transition"] != null) {
        transition = extraParams["transition"] as String;
      }
      if (extraParams["transitionBuilder"] != null) {
        transitionBuilder =
            extraParams["transitionBuilder"] as AnimatedPageTransitionBuilder;
      }
    }
    return _pageTransition(page,
            transition: transition, transitionBuilder: transitionBuilder)
        .routeBuilder;
  }
}

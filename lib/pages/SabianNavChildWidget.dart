import 'package:flutter/material.dart';
import 'package:sabian_tools/pages/SabianPageNavigator.dart';

mixin SabianNavChildMixIn {
  SabianPageNavigator? parentNavigator;
  String? navigationKey;

  void closeNavigation(BuildContext context, {String? key}) {
    SabianPageNavigator? navigator;
    String? navKey;

    navigator = parentNavigator;
    navKey = navigationKey;

    navKey ??= key;

    final mNavigator = navigator ?? SabianPageNavigator();
    if (navKey != null) {
      mNavigator.hide(context, navKey, hideIfRouteNotFound: true);
      return;
    }
    mNavigator.hideLast(context);
  }
}

abstract class SabianNavChildStatelessWidget extends StatelessWidget
    with SabianNavChildMixIn {
  @override
  SabianPageNavigator? parentNavigator;

  @override
  String? navigationKey;

  SabianNavChildStatelessWidget(
      {super.key, this.parentNavigator, this.navigationKey});
}

abstract class SabianNavChildStatefulWidget extends StatefulWidget
    with SabianNavChildMixIn {
  @override
  SabianPageNavigator? parentNavigator;

  @override
  String? navigationKey;

  SabianNavChildStatefulWidget(
      {super.key, this.parentNavigator, this.navigationKey});
}

abstract class SabianNavChildState<T extends SabianNavChildStatefulWidget>
    extends State<T> {
  SabianPageNavigator? get pageNavigator => widget.parentNavigator;

  String? get navigationKey => widget.navigationKey;
}

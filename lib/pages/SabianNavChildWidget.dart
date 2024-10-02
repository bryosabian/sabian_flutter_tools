import 'package:flutter/material.dart';
import 'package:sabian_tools/pages/SabianAnimatedPageNavigator.dart';
import 'package:sabian_tools/pages/SabianGlobalPageNavigator.dart';
import 'package:sabian_tools/pages/SabianPageNavigator.dart';

mixin SabianNavChildMixIn {
  // SabianPageNavigator? parentNavigator;
  String? navigationKey;

  //
  // SabianPageNavigator get navigator => parentNavigator ?? SabianPageNavigator();

  void closeNavigation(BuildContext context, {String? key}) {
    SabianPageNavigator? navigator;
    String? navKey;

    navigator = SabianGlobalPageNavigator.of(context)?.navigator;
    navKey = navigationKey;

    navKey ??= key;

    final mNavigator = navigator ?? SabianAnimatedPageNavigator();
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
  String? navigationKey;

  SabianNavChildStatelessWidget({super.key, this.navigationKey});
}

abstract class SabianNavChildStatefulWidget extends StatefulWidget
    with SabianNavChildMixIn {
  @override
  final String? navigationKey;

  SabianNavChildStatefulWidget({super.key, this.navigationKey});
}

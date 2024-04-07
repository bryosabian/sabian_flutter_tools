import 'dart:collection';

import 'package:flutter/material.dart';

class SabianPageNavigator<T extends Widget> {
  final LinkedHashMap<String, Route> _routes = LinkedHashMap();

  /// Shows the modal and returns the key to be tracked by route asynchronously
  Future<String> showAsync(BuildContext context, String key, T page,
      {bool maintainState = false, bool fullscreenDialog = false}) async {
    Route<T> route = getAndRegisterRoute(context, key, page,
        maintainState: maintainState, fullscreenDialog: fullscreenDialog);
    await Navigator.of(context).push(route);
    return key;
  }

  /// Shows the modal and returns the key to be tracked by route
  String show(BuildContext context, String key, T page,
      {bool maintainState = false, bool fullscreenDialog = false}) {
    Route<T> route = getAndRegisterRoute(context, key, page,
        maintainState: maintainState, fullscreenDialog: fullscreenDialog);
    Navigator.of(context).push(route);
    return key;
  }

  @protected
  Route<T> getAndRegisterRoute(BuildContext context, String key, T modal,
      {bool returnIfExists = false,
      bool maintainState = false,
      bool fullscreenDialog = false}) {
    if (returnIfExists) {
      Route? oldRoute = getRoute(key);
      if (oldRoute != null && oldRoute.isActive && oldRoute is Route<T>) {
        return oldRoute;
      }
    }
    Route<T> route = buildRoute(context,
        page: modal,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog);

    registerRoute(key, route);

    return route;
  }

  @protected
  Route<T> buildRoute(BuildContext context,
      {bool fullscreenDialog = false,
      required T page,
      required bool maintainState}) {
    return MaterialPageRoute<T>(
        fullscreenDialog: fullscreenDialog,
        builder: (context) => page,
        maintainState: maintainState);
  }

  void hideLast(BuildContext context) {
    hide(context, "", hideIfRouteNotFound: true);
  }

  void hide(BuildContext context, String key,
      {bool hideIfRouteNotFound = false}) {
    Route? mRoute = _routes[key];
    if (mRoute == null) {
      if (hideIfRouteNotFound) {
        Navigator.of(context).pop();
      }
      return;
    }
    if (mRoute.isActive) {
      Navigator.of(context).removeRoute(mRoute);
    }
    _routes.remove(key);
  }

  @protected
  void registerRoute(String key, Route<T> route) {
    _routes[key] = route;
  }

  @protected
  Route? getRoute(String key) {
    return _routes[key];
  }
}

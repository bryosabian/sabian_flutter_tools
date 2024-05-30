import 'dart:collection';

import 'package:flutter/material.dart';

class SabianPageNavigator<T extends Widget> {
  final LinkedHashMap<String, Route> _routes = LinkedHashMap();

  /// Shows the modal and returns the key to be tracked by route asynchronously
  Future<String> showAsync(BuildContext context, String key, T page,
      {bool maintainState = false,
      bool fullscreenDialog = false,
      Map<String, Object>? extraParams}) async {
    Route<T> route = getAndRegisterRoute(context, key, page,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        extraParams: extraParams);
    await Navigator.of(context).push(route);
    return key;
  }

  /// Shows the modal and returns the key to be tracked by route
  String show(BuildContext context, String key, T page,
      {bool maintainState = false,
      bool fullscreenDialog = false,
      Map<String, Object>? extraParams}) {
    Route<T> route = getAndRegisterRoute(context, key, page,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        extraParams: extraParams);
    Navigator.of(context).push(route);
    return key;
  }

  @protected
  Route<T> getAndRegisterRoute(BuildContext context, String key, T modal,
      {bool returnIfExists = false,
      bool maintainState = false,
      bool fullscreenDialog = false,
      Map<String, Object>? extraParams}) {
    if (returnIfExists) {
      Route? oldRoute = getRoute(key);
      if (oldRoute != null && oldRoute.isActive && oldRoute is Route<T>) {
        return oldRoute;
      }
    }
    Route<T> route = buildRoute(context,
        page: modal,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        extraParams: extraParams);

    registerRoute(key, route);

    return route;
  }

  @protected
  Route<T> buildRoute(BuildContext context,
      {bool fullscreenDialog = false,
      required T page,
      required bool maintainState,
      Map<String, Object>? extraParams}) {
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

  ///Hides all routes and shows
  void hideAllAndShow(BuildContext context, T page,
      {String? key, Map<String, Object>? extraParams}) {
    final route =
        getAndRegisterRoute(context, key ?? "", page, extraParams: extraParams);
    Navigator.of(context)
        .pushAndRemoveUntil(route, (Route<dynamic> route) => false);
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

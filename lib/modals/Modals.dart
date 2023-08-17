import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sabian_tools/modals/SabianModal.dart';

typedef Modal = Widget;

class Modals {

  static final Modals _singleton = Modals._internal();

  factory Modals.instance() {
    return _singleton;
  }

  Modals._internal();

  final LinkedHashMap<String, Route> _routes = LinkedHashMap();

  /// Shows the modal and returns the key to be tracked by route asynchronously
  Future<String> showAsync<T extends Modal>(
      BuildContext context, String key, T modal) async {
    Route<T> route = _getAndRegisterRoute(context, key, modal);
    await Navigator.of(context).push(route);
    return key;
  }

  /// Shows the modal and returns the key to be tracked by route
  String show<T extends Modal>(BuildContext context, String key, T modal) {
    Route<T> route = _getAndRegisterRoute(context, key, modal);
    Navigator.of(context).push(route);
    return key;
  }

  Route<T> _getAndRegisterRoute<T extends Modal>(
      BuildContext context, String key, T modal,
      {bool returnIfExists = false}) {
    if (returnIfExists) {
      Route? oldRoute = _getRoute(key);
      if (oldRoute != null && oldRoute.isActive && oldRoute is Route<T>) {
        return oldRoute;
      }
    }
    bool isDismissibleOnTouch = true;
    if (modal is SabianModalWidget) {
      isDismissibleOnTouch = modal.isDismissibleOnTouch ?? true;
    }
    Route<T> route = DialogRoute<T>(
        context: context,
        builder: (context) => modal,
        barrierDismissible: isDismissibleOnTouch,
        barrierLabel: MaterialLocalizations.of(context).alertDialogLabel);
    _registerRoute(key, route);
    return route;
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

  void _registerRoute<T extends Modal>(String key, Route<T> route) {
    _routes[key] = route;
  }

  Route? _getRoute<T extends Modal>(String key) {
    return _routes[key];
  }

  ///Shows without key
  static Future<T?> showFullModal<T extends Widget>(
      BuildContext context, Widget modal,
      {bool? barrierDismissible, Color? backColor, String? label}) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      barrierColor: backColor ?? Colors.black54,
      barrierLabel: label ?? MaterialLocalizations.of(context).alertDialogLabel,
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return modal;
      },
    );
  }

  ///Shows without key
  static Future<T?> showModal<T extends Widget>(
      BuildContext context, Widget modal,
      {bool? barrierDismissible, Color? backColor, String? label}) {
    return showDialog(
        context: context,
        barrierDismissible: barrierDismissible ?? true,
        barrierColor: backColor,
        barrierLabel: label ?? MaterialLocalizations.of(context).alertDialogLabel,
        builder: (_) => modal);
  }

  ///Hides without key
  static void hideModal(BuildContext context) {
    Navigator.of(context).pop();
  }
}

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sabian_tools/modals/SabianModal.dart';
import 'package:sabian_tools/pages/SabianPageNavigator.dart';

typedef Modal = Widget;

class Modals extends SabianPageNavigator<Modal> {
  static final Modals _singleton = Modals._internal();

  factory Modals.instance() {
    return _singleton;
  }

  Modals._internal();

  @override
  Route<Modal> buildRoute(BuildContext context,
      {bool fullscreenDialog = false,
      required Modal page,
      required bool maintainState,
      Map<String, Object>? extraParams}) {
    bool isDismissibleOnTouch = true;
    if (page is SabianModalWidget) {
      isDismissibleOnTouch = page.isDismissibleOnTouch ?? true;
    }
    return DialogRoute<Modal>(
        context: context,
        builder: (context) => page,
        barrierDismissible: isDismissibleOnTouch,
        barrierLabel: MaterialLocalizations.of(context).alertDialogLabel);
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
        barrierLabel:
            label ?? MaterialLocalizations.of(context).alertDialogLabel,
        builder: (_) => modal);
  }

  ///Hides without key
  static void hideModal(BuildContext context) {
    Navigator.of(context).pop();
  }
}

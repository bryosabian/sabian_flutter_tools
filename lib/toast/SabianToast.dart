import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';
import 'package:sabian_tools/toast/SabianToastAnim.dart';
import 'package:sabian_tools/toast/SabianToastPosition.dart';
import 'package:sabian_tools/toast/SabianToastType.dart';

typedef SabianToastAction = Function(SabianToast);

class SabianToast {
  final String text;
  final IconData? icon;
  final SabianToastType type;
  Widget? actionText;
  SabianToastAction? action;
  Duration? duration;
  final SabianToastAnim animation;
  final SabianToastPosition position;
  final EdgeInsets? horizontalSpace;
  final BorderRadius? boxRadius;
  final Size? actionSize;
  final bool? dismissOtherToast;

  ToastFuture? _lastToast;

  bool _isShowing = false;

  SabianToast(this.text, this.type,
      {this.icon,
        this.actionText,
        this.action,
        this.duration,
        this.animation = SabianToastAnim.fade,
        this.position = SabianToastPosition.top,
        this.horizontalSpace = const EdgeInsets.only(left: 0, right: 0),
        this.boxRadius = BorderRadius.zero,
        this.actionSize = const Size(0, 20),
        this.dismissOtherToast});

  factory SabianToast.withTextAction(String text, SabianToastType type,
      {required String actionText,
        SabianToastAction? action,
        IconData? icon,
        Duration? duration,
        SabianToastAnim animation = SabianToastAnim.fade,
        SabianToastPosition position = SabianToastPosition.top,
        EdgeInsets horizontalSpace = const EdgeInsets.only(left: 0, right: 0),
        BorderRadius boxRadius = BorderRadius.zero,
        Size actionSize = const Size(0, 20),
        Color? actionTextColor,
        bool? dismissOtherToast}) {
    return SabianToast(text, type,
        icon: icon,
        action: action,
        duration: duration,
        animation: animation,
        position: position,
        horizontalSpace: horizontalSpace,
        boxRadius: boxRadius,
        actionSize: actionSize,
        dismissOtherToast: dismissOtherToast,
        actionText: SabianRobotoText(
          actionText,
          fontSize: 14,
          textColor: actionTextColor,
        ));
  }

  factory SabianToast.withIconAction(String text, SabianToastType type,
      {required IconData actionIcon,
        SabianToastAction? action,
        IconData? icon,
        Duration? duration,
        SabianToastAnim animation = SabianToastAnim.fade,
        SabianToastPosition position = SabianToastPosition.top,
        EdgeInsets horizontalSpace = const EdgeInsets.symmetric(horizontal: 0),
        BorderRadius boxRadius = BorderRadius.zero,
        Size actionSize = const Size(0, 20),
        bool? dismissOtherToast,
        Color? actionIconColor}) {
    return SabianToast(text, type,
        icon: icon,
        action: action,
        duration: duration,
        animation: animation,
        position: position,
        horizontalSpace: horizontalSpace,
        boxRadius: boxRadius,
        actionSize: actionSize,
        dismissOtherToast: dismissOtherToast,
        actionText: Icon(
          actionIcon,
          color: actionIconColor,
          size: actionSize.height,
        ));
  }

  void show(BuildContext context) {
    if (_isShowing || (_lastToast != null && _lastToast!.isShow)) {
      return;
    }
    _lastToast = showToastWidget(
        _SabianToastWidget(this),
        context: context,
        isIgnoring: false,
        duration: duration,
        animation: animation.animation,
        reverseAnimation: animation.animation,
        position: position.position,
        dismissOtherToast: dismissOtherToast
    );

    _isShowing = _lastToast!.isShow;
  }

  void hide({bool withAnim = true}) {
    if (_lastToast != null && _lastToast!.isShow) {
      _lastToast!.dismiss(showAnim: withAnim).then((value) {
        _isShowing = false;
        _lastToast = null;
      });
    }
  }
}

class _SabianToastWidget extends StatelessWidget {
  static const _ICON_SIZE = 20.0;
  static const _FONT_SIZE = 20.0;

  final SabianToast _toast;

  const _SabianToastWidget(this._toast);

  @override
  Widget build(BuildContext context) {
    final textColor = _toast.type.getTextColor(context);

    final bgColor = _toast.type.getBackgroundColor(context);

    final List<Widget> bodyChildren = [];

    if (_toast.icon != null) {
      bodyChildren.add(Icon(
        _toast.icon,
        size: _ICON_SIZE,
        color: textColor,
      ));
    }


    double actionPadding = 5.0;

    if (_toast.actionText != null) {
      actionPadding = 10.0;
    }

    bodyChildren.add(
        Flexible(
            child: Container(
                margin: EdgeInsets.only(left: 5,right: actionPadding),
                child: SabianRobotoText(
                  _toast.text,
                  softwrap: true,
                  type: "Regular",
                  fontSize: _FONT_SIZE,
                  fontWeight: FontWeight.normal,
                  textColor: textColor,
                ))));

    double? actionWidth = _toast.actionSize?.width;
    double? actionHeight = _toast.actionSize?.height;
    if (actionWidth != null && actionWidth <= 0) {
      actionWidth = null;
    }
    if (actionHeight != null && actionHeight <= 0) {
      actionHeight = null;
    }


    return FractionallySizedBox(

      child: Padding(

          padding: _toast.horizontalSpace ??
              const EdgeInsets.only(left: 20, right: 20),

          child: Container(
              padding: const EdgeInsets.only(
                  left: 10, top: 15, right: 10, bottom: 15),

              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: _toast.boxRadius ??
                      const BorderRadius.all(Radius.circular(5))),

              child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: bodyChildren,
                    ),

                    //Action
                    Visibility(
                        visible: _toast.actionText != null,
                        child: Container(
                            width: actionWidth,
                            height: actionHeight,
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: _onAction, child: _toast.actionText)))
                  ]))),
    );
  }

  void _onAction() {
    _toast.action?.call(_toast);
  }
}

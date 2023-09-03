import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';
import 'package:sabian_tools/toast/SabianToastAnim.dart';
import 'package:sabian_tools/toast/SabianToastPosition.dart';
import 'package:sabian_tools/toast/SabianToastType.dart';

class SabianToast {
  final String text;
  final IconData? icon;
  final SabianToastType type;
  final Widget? actionText;
  final Function(SabianToast)? action;
  final Duration? duration;
  final SabianToastAnim animation;
  final SabianToastPosition position;
  final EdgeInsets? horizontalSpace;
  final BorderRadius? boxRadius;
  final Size? actionSize;

  ToastFuture? _lastToast;
  bool _isShowing = false;

  SabianToast(
      {required this.text,
      this.icon,
      required this.type,
      this.actionText,
      this.action,
      this.duration,
      this.animation = SabianToastAnim.fade,
      this.position = SabianToastPosition.top,
      this.horizontalSpace = const EdgeInsets.only(left: 0, right: 0),
      this.boxRadius = BorderRadius.zero,
      this.actionSize = const Size(0, 20)});

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
    bodyChildren.add(Container(
        margin: const EdgeInsets.only(left: 5),
        child: SabianRobotoText(
          _toast.text,
          type: "Regular",
          fontSize: _FONT_SIZE,
          fontWeight: FontWeight.normal,
          textColor: textColor,
        )));

    double? actionWidth = _toast.actionSize?.width;
    double? actionHeight = _toast.actionSize?.height;
    if(actionWidth != null && actionWidth <= 0){
      actionWidth = null;
    }
    if(actionHeight != null && actionHeight <= 0){
      actionHeight = null;
    }

    return Container(
        width: MediaQuery.of(context).size.width,
        padding: _toast.horizontalSpace ??
            const EdgeInsets.only(left: 20, right: 20),
        color: Colors.black.withOpacity(0),
        child: Container(
            padding:
                const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: _toast.boxRadius ??
                    const BorderRadius.all(Radius.circular(5))),
            child: Stack(children: [
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
            ])));
  }

  void _onAction() {
    _toast.action?.call(_toast);
  }
}

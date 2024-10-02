import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianWrappedRobotoText.dart';
import 'package:sabian_tools/modals/AbstractSabianModal.dart';
import 'package:sabian_tools/modals/SabianModal.dart';
import 'package:sabian_tools/modals/Transitions.dart';

class SabianHeaderModal extends SabianModal {
  final Color? headerColor;
  final Color? onHeaderColor;
  final double headerHeight;
  final bool Function(BuildContext, AbstractSabianModal)? onHeaderClose;

  SabianHeaderModal(
      {super.key,
      super.title,
      super.message,
      super.contentBody,
      super.buttons,
      super.divideContent,
      super.dividerThickness,
      this.headerHeight = 80,
      this.headerColor,
      this.onHeaderColor,
      this.onHeaderClose,
      super.isDismissible = false,
      super.isDismissibleOnTouch = true,
      super.contentPadding,
      super.opacityPadding,
      ThemeData? theme,
      super.transition = "slide_up",
      Duration transitionDuration = const Duration(milliseconds: 200),
      SabianModalTransition? customTransition})
      : super(
            theme: theme,
            transitionDuration: transitionDuration,
            customTransition: customTransition);

  @override
  Widget build(BuildContext context) {
    return _SabianHeaderModalWidget(
      parent: this,
      title: title,
      body: body,
      buttons: buttons,
      message: message,
      contentBody: contentBody,
      divideContent: divideContent,
      dividerThickness: dividerThickness,
      isDismissible: isDismissible,
      isDismissibleOnTouch: isDismissibleOnTouch,
      theme: theme,
      borderRadius: borderRadius,
      buttonAlignment: buttonAlignment,
      backColor: backColor,
      transition: transition,
      transitionDuration: transitionDuration,
      customTransition: customTransition,
      contentPadding: contentPadding,
      opacityPadding: opacityPadding,
    );
  }
}

class _SabianHeaderModalWidget extends SabianModalWidget {
  const _SabianHeaderModalWidget(
      {super.parent,
      super.body,
      super.title,
      super.message,
      super.contentBody,
      super.buttons,
      super.theme,
      super.borderRadius,
      super.buttonAlignment,
      super.isDismissible,
      super.isDismissibleOnTouch,
      super.backColor,
      super.divideContent,
      super.dividerThickness,
      super.transition = "fade",
      super.transitionDuration = const Duration(milliseconds: 200),
      super.customTransition,
      super.contentPadding,
      super.opacityPadding});

  @override
  State<StatefulWidget> createState() {
    return _SabianHeaderModal();
  }
}

class _SabianHeaderModal
    extends SabianModalWidgetState<_SabianHeaderModalWidget> {
  SabianHeaderModal get headerModal => widget.parent as SabianHeaderModal;

  @override
  Widget getDefaultHeader(BuildContext context, ThemeData theme) {
    ColorScheme colorScheme = theme.colorScheme;
    Color bgColor = headerModal.headerColor ?? colorScheme.primary;
    Color textColor = headerModal.onHeaderColor ?? colorScheme.onPrimary;
    const padding = EdgeInsets.symmetric(vertical: 10, horizontal: 10);
    BorderRadius radius = bodyBorderRadius;
    Radius topLeft = radius.topLeft;
    Radius topRight = radius.topRight;
    const double iconSize = 30;
    return Stack(fit: StackFit.loose, children: [
      Container(
          constraints: BoxConstraints(minHeight: headerModal.headerHeight),
          decoration: ShapeDecoration(
              color: bgColor,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(topLeft: topLeft, topRight: topRight))),
          padding: padding,
          child: Center(
            child: SabianWrappedRobotoText(
              isParentFlexible: false,
              headerModal.title ?? "",
              textColor: textColor,
              fontSize: 14,
            ),
          )),
      Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
              onTap: () {
                _tryClose(context);
              },
              child: Padding(
                  padding: padding,
                  child: Icon(Icons.clear, size: iconSize, color: textColor))))
    ]);
  }

  void _tryClose(BuildContext context) {
    if (headerModal.onHeaderClose != null) {
      if (headerModal.onHeaderClose!.call(context, widget.parent!)) {
        close(context);
      }
    } else {
      close(context);
    }
  }
}

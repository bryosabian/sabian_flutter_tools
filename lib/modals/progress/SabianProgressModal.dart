import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';
import 'package:sabian_tools/modals/AbstractSabianModal.dart';
import 'package:sabian_tools/modals/SabianModal.dart';
import 'package:sabian_tools/modals/Transitions.dart';
import 'package:sabian_tools/modals/progress/ISabianProgressType.dart';
import 'package:sabian_tools/themes/SabianThemeExtension.dart';

class SabianProgressModal extends SabianModal {
  final ISabianProgressType type;

  SabianProgressModal(
      {super.key,
      super.title,
      super.message,
      this.type = const CircleProgressType(),
      bool? isDismissable = false,
      bool? isDismissableOnTouch = false,
      ThemeData? theme,
      super.transition = "fade",
      Duration? transitionDuration = const Duration(milliseconds: 200),
      SabianModalTransition? customTransition})
      : super(
            theme: theme,
            isDismissible: isDismissable,
            isDismissibleOnTouch: isDismissableOnTouch,
            transitionDuration: transitionDuration,
            customTransition: customTransition);

  SabianProgressModal.of(String title,
      {super.key,
      super.message,
      this.type = const CircleProgressType(),
      super.transition = 'fade'})
      : super(title: title);

  @override
  Widget build(BuildContext context) {
    return SabianProgressModalWidget(
      parent: this,
      title: title,
      message: message,
      type: type,
      isDismissable: isDismissible!,
      isDismissableOnTouch: isDismissibleOnTouch!,
      theme: theme,
      transition: transition,
      transitionDuration: transitionDuration,
      customTransition: customTransition,
    );
  }

  @override
  Future show<T>(BuildContext context, {bool isFull = false}) {
    return super.show(context, isFull: isFull);
  }
}

class SabianProgressModalWidget extends SabianModalWidget {
  final ISabianProgressType type;

  const SabianProgressModalWidget(
      {Key? key,
      AbstractSabianModal? parent,
      String? title,
      String? message,
      this.type = const CircleProgressType(),
      bool? isDismissable = false,
      bool? isDismissableOnTouch = false,
      ThemeData? theme,
      String? transition = "fade",
      Duration? transitionDuration = const Duration(milliseconds: 200),
      SabianModalTransition? customTransition})
      : super(
            key: key,
            parent: parent,
            title: title,
            message: message,
            theme: theme,
            transition: transition,
            isDismissible: isDismissable,
            isDismissibleOnTouch: isDismissableOnTouch,
            transitionDuration: transitionDuration,
            customTransition: customTransition);

  @override
  State<StatefulWidget> createState() {
    return _SabianProgressState();
  }
}

class _SabianProgressState
    extends SabianModalWidgetState<SabianProgressModalWidget> {
  @override
  Widget getBody(BuildContext context, ThemeData theme) {
    ColorScheme colorScheme = theme.colorScheme;
    SabianThemeExtension? sabianTheme = theme.extension<SabianThemeExtension>();
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, //Make it wrap
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max, //Make
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 3),
                      child: widget.type.create(ProgressPayload(
                          context: context,
                          parent: widget,
                          theme: theme,
                          defaultSize: const Size(36, 36)))),
                  Flexible(
                      child: Container(
                          margin: const EdgeInsets.only(right: 4),
                          child: SabianRobotoText(
                            widget.title ?? "",
                            overflow: TextOverflow.ellipsis,
                            textColor: sabianTheme?.dialogTextColor ??
                                colorScheme.onSurface,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ))),
                  Flexible(
                      child: SabianRobotoText(
                    widget.message ?? "",
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    textColor:
                        sabianTheme?.dialogTextColor ?? colorScheme.onSurface,
                  ))
                ],
              ))
        ]);
  }
}

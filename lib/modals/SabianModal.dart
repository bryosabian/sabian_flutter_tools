import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';
import 'package:sabian_tools/controls/SabianTextButton.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';
import 'package:sabian_tools/modals/AbstractSabianModal.dart';
import 'package:sabian_tools/modals/Transitions.dart';
import 'package:sabian_tools/themes/SabianThemeExtension.dart';

class SabianModal extends AbstractSabianModal {
  final Widget? body;

  String? title;

  String? message;

  final Widget? messageBody;

  final ThemeData? theme;

  final BorderRadius? borderRadius;

  final List<SabianModalButton>? buttons;

  final MainAxisAlignment? buttonAlignment;

  final double? dividerThickness;

  final bool? divideContent;

  final String? transition;

  final Duration? transitionDuration;

  final SabianModalTransition? customTransition;

  SabianModal({
    String? key,
    this.body,
    this.title,
    this.message,
    this.messageBody,
    this.buttons,
    this.theme,
    this.borderRadius,
    this.buttonAlignment,
    bool? isDismissible,
    bool? isDismissibleOnTouch,
    Color? backColor,
    this.dividerThickness,
    this.divideContent,
    this.transition = "fade",
    this.transitionDuration = const Duration(milliseconds: 200),
    this.customTransition,
  }) : super(
          key: key,
          backColor: backColor,
          isDismissible: isDismissible,
          isDismissibleOnTouch: isDismissibleOnTouch,
        );

  @override
  Widget build(BuildContext context) {
    return SabianModalWidget(
        parent: this,
        body: body,
        title: title,
        message: message,
        messageBody: messageBody,
        buttons: buttons,
        theme: theme,
        borderRadius: borderRadius,
        buttonAlignment: buttonAlignment,
        isDismissible: isDismissible,
        isDismissibleOnTouch: isDismissibleOnTouch,
        backColor: backColor,
        dividerThickness: dividerThickness,
        divideContent: divideContent,
        transition: transition,
        transitionDuration: transitionDuration,
        customTransition: customTransition);
  }

  void update({String? title, String? message, bool notifyWhenChanged = true}) {
    this.title = title ?? this.title;
    this.message = message ?? this.message;
    if (notifyWhenChanged) {
      bool can = [title, message]
          .any((element) => element != null && !element.isBlankOrEmpty);
      if (!can) {
        return;
      }
    }
    if (notifyWhenChanged) {
      notifyChanged();
    }
  }
}

class SabianModalWidget extends AbstractSabianModalWidget {
  final Widget? body;

  final String? title;

  final String? message;

  final Widget? messageBody;

  final BorderRadius? borderRadius;

  final List<SabianModalButton>? buttons;

  final MainAxisAlignment? buttonAlignment;

  final double? dividerThickness;

  final bool? divideContent;

  const SabianModalWidget(
      {Key? key,
      AbstractSabianModal? parent,
      this.body,
      this.title,
      this.message,
      this.messageBody,
      this.buttons,
      ThemeData? theme,
      this.borderRadius,
      this.buttonAlignment,
      bool? isDismissible,
      bool? isDismissibleOnTouch,
      backColor,
      this.dividerThickness,
      this.divideContent,
      String? transition = "fade",
      Duration? transitionDuration = const Duration(milliseconds: 200),
      SabianModalTransition? customTransition})
      : super(
            key: key,
            parent: parent,
            isDismissible: isDismissible,
            isDismissibleOnTouch: isDismissibleOnTouch,
            backColor: backColor,
            transition: transition,
            transitionDuration: transitionDuration,
            customTransition: customTransition,
            theme: theme);

  @override
  State<StatefulWidget> createState() {
    return SabianModalWidgetState();
  }
}

class SabianModalWidgetState<T extends SabianModalWidget>
    extends AbstractSabianModalState<T> {
  static const EdgeInsets MARGIN = EdgeInsets.all(20.0);

  static const EdgeInsets PADDING = EdgeInsets.all(15.0);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = getTheme(context);

    SabianThemeExtension? sabianTheme = theme.extension<SabianThemeExtension>();

    Widget child = WillPopScope(
        onWillPop: () => onBackPressed(),
        child: Center(
            child: Container(
                margin: MARGIN,
                decoration: ShapeDecoration(
                    color: sabianTheme?.dialogBackgroundColor ??
                        theme.dialogBackgroundColor,
                    shape: RoundedRectangleBorder(borderRadius: getRadius())),
                child: widget.body ?? getDefaultChild(context, theme))));

    return currentTransition.getParent(animation: animation, child: child);
  }

  BorderRadius getRadius() {
    return widget.borderRadius ?? BorderRadius.circular(15.0);
  }

  Widget getDefaultChild(BuildContext context, ThemeData theme) {
    final canDivide = widget.divideContent ?? true;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, //Make it wrap content the items
        children: [
          //Header
          getDefaultHeader(context, theme),

          //Divider
          if (canDivide) getDivider(theme),

          //Body
          getDefaultBody(context, theme),

          //Divider
          if (canDivide) getDivider(theme),

          //Footer
          getDefaultFooter(context, theme)
        ]);
  }

  Widget getDefaultHeader(BuildContext context, ThemeData theme) {
    final canDivide = widget.divideContent ?? true;
    ColorScheme colorScheme = theme.colorScheme;
    SabianThemeExtension? sabianTheme = theme.extension<SabianThemeExtension>();
    return Padding(
        padding: EdgeInsets.only(
            left: PADDING.left,
            top: PADDING.top,
            right: PADDING.right,
            bottom: canDivide ? PADDING.bottom : 2),
        child: SabianRobotoText(widget.title!,
            textColor: sabianTheme?.dialogTitleColor ?? colorScheme.onSurface,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            type: "Regular"));
  }

  Widget getDefaultBody(BuildContext context, ThemeData theme) {
    final canDivide = widget.divideContent ?? true;
    ColorScheme colorScheme = theme.colorScheme;
    SabianThemeExtension? sabianTheme = theme.extension<SabianThemeExtension>();
    return Flexible(
        fit: FlexFit.loose,
        child: Padding(
            padding: EdgeInsets.only(
                left: PADDING.left,
                top: PADDING.top,
                right: PADDING.right,
                bottom: canDivide ? PADDING.bottom : 2),
            child: widget.messageBody ??
                SabianRobotoText(widget.message!,
                    textColor:
                        sabianTheme?.dialogTextColor ?? colorScheme.onSurface,
                    fontSize: 13,
                    fontWeight: FontWeight.normal)));
  }

  Widget getDefaultFooter(BuildContext context, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(
          left: PADDING.left, top: 2, right: PADDING.right, bottom: 4),
      child: _getButtons(context, theme),
    );
  }

  Widget? _getButtons(BuildContext context, ThemeData theme) {
    List<SabianModalButton> buttons = widget.buttons ?? [];
    List<Widget> buttonWidgets = buttons
        .map((button) => _getSingleButton(context, theme, button))
        .toList(growable: false);
    return Row(
      mainAxisAlignment: widget.buttonAlignment ?? MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: buttonWidgets,
    );
  }

  Widget _getSingleButton(
      BuildContext context, ThemeData theme, SabianModalButton button) {
    SabianThemeExtension? sabianTheme = theme.extension<SabianThemeExtension>();
    return Container(
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.only(right: 0),
        child: SabianTextButton(
          button.title,
          onPressed: () {
            if (widget.parent != null)
              button.onClick?.call(widget.parent!, context);
          },
          textColor: button.color ??
              (sabianTheme?.dialogButtonColor ?? theme.primaryColor),
        ));
  }

  Divider getDivider(ThemeData theme) {
    double thick = widget.dividerThickness ?? 0.5;
    return Divider(height: thick, thickness: thick, color: theme.dividerColor);
  }
}

class SabianModalButton {
  final String title;
  final Color? color;
  Function(AbstractSabianModal, BuildContext)? onClick;

  SabianModalButton(this.title, {this.color, this.onClick});
}

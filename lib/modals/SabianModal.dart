import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';
import 'package:sabian_tools/controls/SabianTextButton.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';
import 'package:sabian_tools/modals/AbstractSabianModal.dart';
import 'package:sabian_tools/modals/Transitions.dart';
import 'package:sabian_tools/themes/SabianThemeExtension.dart';

class SabianModal extends AbstractSabianModal {
  static const EdgeInsets defaultMargin = EdgeInsets.all(20.0);

  static const EdgeInsets defaultBodyPadding = EdgeInsets.all(15.0);

  static const EdgeInsets defaultHeaderPadding = EdgeInsets.all(15.0);

  final Widget? body;

  final Widget? header;

  final Widget? footer;

  String? title;

  String? message;

  final Widget? contentBody;

  final ThemeData? theme;

  final BorderRadius? borderRadius;

  final List<SabianModalButton>? buttons;

  final MainAxisAlignment? buttonAlignment;

  final double? dividerThickness;

  final bool? divideContent;

  final bool? divideHeaderContent;

  final bool? divideFooterContent;

  final String? transition;

  final Duration? transitionDuration;

  final SabianModalTransition? customTransition;

  final EdgeInsets? opacityPadding;

  final EdgeInsets? contentPadding;

  final EdgeInsets? headerPadding;

  final EdgeInsets? footerPadding;

  final Size? modalSize;

  final bool? displayHeader;

  final bool? displayFooter;

  SabianModal({
    String? key,
    this.body,
    this.title,
    this.message,
    this.contentBody,
    this.buttons,
    this.theme,
    this.borderRadius,
    this.buttonAlignment,
    bool? isDismissible,
    bool? isDismissibleOnTouch,
    Color? backColor,
    this.dividerThickness,
    this.divideContent,
    this.divideHeaderContent,
    this.divideFooterContent,
    this.transition = "slide_up",
    this.transitionDuration = const Duration(milliseconds: 200),
    this.customTransition,
    this.opacityPadding,
    this.contentPadding,
    this.modalSize,
    this.headerPadding,
    this.footerPadding,
    this.displayHeader,
    this.displayFooter,
    this.header,
    this.footer,
  }) : super(
          key: key,
          backColor: backColor,
          isDismissible: isDismissible,
          isDismissibleOnTouch: isDismissibleOnTouch,
        );

  @override
  Widget build(BuildContext context) {
    return SabianModalWidget(
      header: header,
      footer: footer,
      parent: this,
      body: body,
      title: title,
      message: message,
      contentBody: contentBody,
      buttons: buttons,
      theme: theme,
      borderRadius: borderRadius,
      buttonAlignment: buttonAlignment,
      isDismissible: isDismissible,
      isDismissibleOnTouch: isDismissibleOnTouch,
      backColor: backColor,
      dividerThickness: dividerThickness,
      divideContent: divideContent,
      divideHeaderContent: divideHeaderContent,
      divideFooterContent: divideFooterContent,
      transition: transition,
      transitionDuration: transitionDuration,
      customTransition: customTransition,
      opacityPadding: opacityPadding,
      contentPadding: contentPadding,
      modalSize: modalSize,
      headerPadding: headerPadding,
      footerPadding: footerPadding,
      displayHeader: displayHeader,
      displayFooter: displayFooter,
    );
  }

  bool update({String? title, String? message, bool notifyWhenChanged = true}) {
    bool can = [title, message]
        .any((element) => element != null && !element.isBlankOrEmpty);

    if (!can) {
      return false;
    }

    if (can) {
      can = this.title != title;
    }

    if (!can) {
      can = this.message != message;
    }

    if (can) {
      this.title = title ?? this.title;

      this.message = message ?? this.message;

      if (notifyWhenChanged) {
        notifyChanged();
      }
    }

    return can;
  }
}

class SabianModalWidget extends AbstractSabianModalWidget {
  final Widget? body;

  final String? title;

  final String? message;

  final Widget? contentBody;

  final Widget? header;

  final Widget? footer;

  final BorderRadius? borderRadius;

  final List<SabianModalButton>? buttons;

  final MainAxisAlignment? buttonAlignment;

  final double? dividerThickness;

  final bool? divideContent;

  final bool? divideHeaderContent;

  final bool? divideFooterContent;

  final EdgeInsets? opacityPadding;

  final EdgeInsets? contentPadding;

  final EdgeInsets? headerPadding;

  final EdgeInsets? footerPadding;

  final bool? displayHeader;

  final bool? displayFooter;

  final Size? modalSize;

  const SabianModalWidget(
      {Key? key,
      AbstractSabianModal? parent,
      this.body,
      this.title,
      this.message,
      this.contentBody,
      this.buttons,
      ThemeData? theme,
      this.borderRadius,
      this.buttonAlignment,
      bool? isDismissible,
      bool? isDismissibleOnTouch,
      backColor,
      this.dividerThickness,
      this.divideContent,
      this.divideHeaderContent,
      this.divideFooterContent,
      this.opacityPadding,
      this.contentPadding,
      this.headerPadding,
      this.footerPadding,
      this.modalSize,
      this.displayHeader,
      this.displayFooter,
      this.header,
      this.footer,
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
  @protected
  EdgeInsets get opacityPadding =>
      widget.opacityPadding ?? SabianModal.defaultMargin;

  @protected
  EdgeInsets get bodyPadding =>
      widget.contentPadding ?? SabianModal.defaultBodyPadding;

  @protected
  Size? get modalSize => widget.modalSize;

  bool get _canDividerHeader =>
      widget.divideHeaderContent ?? (widget.divideContent ?? true);

  bool get _canDivideFooter =>
      widget.divideFooterContent ??
      (widget.divideContent ?? true) && _hasFooter;

  bool get _hasFooter => widget.buttons != null && widget.buttons!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = getTheme(context);

    SabianThemeExtension? sabianTheme = theme.extension<SabianThemeExtension>();

    Widget child = PopScope(
        canPop: true,
        onPopInvoked: (_) => onBackPressed(),
        child: Center(
            child: Container(
                height: modalSize?.height,
                width: modalSize?.width,
                margin: opacityPadding,
                decoration: ShapeDecoration(
                    color: sabianTheme?.dialogBackgroundColor ??
                        theme.dialogBackgroundColor,
                    shape:
                        RoundedRectangleBorder(borderRadius: bodyBorderRadius)),
                child: getBody(context, theme))));

    return currentTransition.getParent(animation: animation, child: child);
  }

  @protected
  BorderRadius get bodyBorderRadius {
    return widget.borderRadius ?? BorderRadius.circular(15.0);
  }

  @protected
  Widget getBody(BuildContext context, ThemeData theme) {
    if (widget.body != null) {
      return widget.body!;
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, //Make it wrap content the items
        children: [
          //Header
          if (widget.displayHeader != false)
            widget.header ?? getDefaultHeader(context, theme),

          //Divider
          if (_canDividerHeader && widget.displayHeader != false)
            getDivider(theme),

          //Body
          getDefaultBody(context, theme),

          //Divider
          if (_canDivideFooter && widget.displayFooter != false)
            getDivider(theme),

          //Footer
          if (widget.displayFooter != false)
            widget.footer ?? getDefaultFooter(context, theme)
        ]);
  }

  @protected
  Widget getDefaultHeader(BuildContext context, ThemeData theme) {
    final canDivide = widget.divideContent ?? true;
    ColorScheme colorScheme = theme.colorScheme;
    SabianThemeExtension? sabianTheme = theme.extension<SabianThemeExtension>();
    final headerPadding =
        widget.headerPadding ?? SabianModal.defaultHeaderPadding;
    return Padding(
        padding: EdgeInsets.only(
            left: headerPadding.left,
            top: headerPadding.top,
            right: headerPadding.right,
            bottom: canDivide ? headerPadding.bottom : 2),
        child: SabianRobotoText(widget.title ?? "",
            textColor: sabianTheme?.dialogTitleColor ?? colorScheme.onSurface,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            type: "Regular"));
  }

  @protected
  Widget getDefaultBody(BuildContext context, ThemeData theme) {
    final canDivide = widget.divideContent ?? true;
    ColorScheme colorScheme = theme.colorScheme;
    SabianThemeExtension? sabianTheme = theme.extension<SabianThemeExtension>();
    return Flexible(
        fit: FlexFit.loose,
        child: Padding(
            padding: EdgeInsets.only(
                left: bodyPadding.left,
                top: bodyPadding.top,
                right: bodyPadding.right,
                bottom: canDivide ? bodyPadding.bottom : 2),
            child: widget.contentBody ??
                SabianRobotoText(widget.message!,
                    textColor:
                        sabianTheme?.dialogTextColor ?? colorScheme.onSurface,
                    fontSize: 13,
                    fontWeight: FontWeight.normal)));
  }

  @protected
  Widget getDefaultFooter(BuildContext context, ThemeData theme) {
    return Padding(
      padding: widget.footerPadding ??
          EdgeInsets.only(
              left: SabianModal.defaultBodyPadding.left,
              top: 2,
              right: SabianModal.defaultBodyPadding.right,
              bottom: 4),
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
    return SabianTextButton(
      button.title,
      backgroundColor: Colors.transparent,
      onPressed: () {
        if (widget.parent != null) {
          button.onClick?.call(widget.parent!, context);
        }
      },
      textColor: button.color ??
          (sabianTheme?.dialogButtonColor ?? theme.primaryColor),
    );
  }

  @protected
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

  factory SabianModalButton.close({String text = "Close", Color? color}) {
    return SabianModalButton(text, color: color, onClick: (m, c) {
      m.close(c);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';
import 'package:sabian_tools/themes/SabianColorScheme.dart';
import 'package:sabian_tools/themes/WithSabianThemeMixIn.dart';

class SabianRobotoTextField extends StatelessWidget with WithSabianThemeMixIn {
  final TextEditingController? controller;
  final String? text;
  final String? hint;

  final Color? textColor;
  final Color? hintColor;
  final Color? focusColor;
  final Color? backgroundColor;
  final bool? enabled;

  final String? robotoType;
  final TextInputType? inputType;
  final TextAlign? textAlign;
  final TextDirection? direction;

  final double? fontSize;
  final FontWeight? fontWeight;

  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? disabledBorder;

  /// [Icon] and [ImageIcon], which are typically used to show icons.
  final Widget? prefixIcon;

  /// [Icon] and [ImageIcon], which are typically used to show icons.
  final Widget? suffixIcon;

  final Color? prefixIconColor;

  final Color? suffixIconColor;

  final Color? iconColor;

  final EdgeInsets? contentPadding;

  final int? maxLines;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters], which are called before [onChanged]
  ///    runs and can validate and change ("format") the input value.
  ///  * [onEditingComplete], [onSubmitted]:
  ///    which are more specialized input change notifications.
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [TextInputAction.next] and [TextInputAction.previous], which
  ///    automatically shift the focus to the next/previous focusable item when
  ///    the user is done editing.
  final ValueChanged<String>? onSubmitted;

  ///
  final bool showCloseKeyBoardAction;

  ///
  final String? closeKeyBoardActionTitle;

  ///
  final Color? keyBoardActionBgColor;

  ///
  final Color? onKeyBoardActionBgColor;

  final TextInputAction? textInputAction;

  ///Focus node
  FocusNode? focusNode;

  SabianRobotoTextField({Key? key,
    this.controller,
    this.text,
    this.hint,
    this.textColor,
    this.hintColor,
    this.focusColor,
    this.backgroundColor,
    this.robotoType = "Regular",
    this.inputType,
    this.textAlign,
    this.direction,
    this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.border,
    this.disabledBorder,
    this.focusedBorder,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconColor,
    this.suffixIconColor,
    this.iconColor,
    this.enabled,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.maxLines,
    this.focusNode,
    this.showCloseKeyBoardAction = true,
    this.closeKeyBoardActionTitle,
    this.keyBoardActionBgColor,
    this.onKeyBoardActionBgColor, this.textInputAction})
      : super(key: key) {
    focusNode ??= FocusNode();
  }

  Widget _getField(BuildContext context) {
    TextEditingController? newController;

    if (controller == null && text != null) {
      newController = TextEditingController(text: text);
    }

    Color bgColor = backgroundColor ?? Colors.transparent;

    //Always wrap TextField in a material widget
    return Material(
        color: bgColor,
        child: TextField(
          maxLines: maxLines,
          focusNode: focusNode!,
          enabled: enabled,
          controller: controller ?? newController,
          textAlign: textAlign ?? TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: textInputAction,
          keyboardType: inputType,
          onChanged: onChanged,
          onEditingComplete: (onEditingComplete != null)
              ? () {
            focusNode!.unfocus();
            onEditingComplete!();
          }
              : null,
          onSubmitted: onSubmitted,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: "Roboto%s".format([robotoType ?? "Regular"]),
          ),
          decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: contentPadding,
              focusColor: focusColor ?? Colors.transparent,
              prefixIcon: prefixIcon,
              prefixIconColor: prefixIconColor ?? iconColor,
              suffixIcon: suffixIcon,
              suffixIconColor: suffixIconColor ?? iconColor,
              iconColor: iconColor,
              hintText: hint,
              hintTextDirection: direction,
              border: border,
              disabledBorder: disabledBorder ?? border,
              focusedBorder: focusedBorder ?? border,
              fillColor: Colors.transparent,
              filled: true,
              hintStyle: TextStyle(
                  backgroundColor: Colors.transparent,
                  fontFamily: "Roboto%s".format([robotoType ?? "Regular"]),
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: hintColor ?? textColor)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (!showCloseKeyBoardAction) {
      return _getField(context);
    }
    return KeyboardActions(
        disableScroll: true,
        config: _getKeyboardActions(context),
        child: _getField(context));
  }

  KeyboardActionsConfig _getKeyboardActions(BuildContext context) {
    SabianColorScheme sabianColorScheme = getColorScheme(context);

    Color? actionTextColor = onKeyBoardActionBgColor ??
        (sabianColorScheme.sabianTheme?.onKeyBoardButtonColor ??
            sabianColorScheme.defaultScheme.onBackground);

    Color? actionColor = keyBoardActionBgColor ??
        (sabianColorScheme.sabianTheme?.keyBoardButtonColor ??
            sabianColorScheme.defaultScheme.background);

    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: actionColor,
        nextFocus: true,
        actions: [
          KeyboardActionsItem(
            focusNode: focusNode!,
            toolbarButtons: [
                  (node) {
                return GestureDetector(
                  onTap: () => node.unfocus(),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: SabianRobotoText(closeKeyBoardActionTitle ?? "Close",
                        textColor: actionTextColor),
                  ),
                );
              },
            ],
          ),
        ]);
  }
}

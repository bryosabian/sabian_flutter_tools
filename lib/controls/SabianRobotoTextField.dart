import 'package:flutter/material.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';

class SabianRobotoTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? text;
  final String? hint;

  final Color? textColor;
  final Color? hintColor;
  final Color? focusColor;
  final Color? backgroundColor;

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

  const SabianRobotoTextField(
      {Key? key,
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
      this.onChanged,
      this.onEditingComplete,
      this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController? newController;
    if (controller == null && text != null) {
      newController = TextEditingController(text: text);
    }

    //Always wrap TextField in a material widget
    return Material(
        child: TextField(
      controller: controller ?? newController,
      textAlign: textAlign ?? TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: inputType,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
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
          focusColor: focusColor ?? textColor,
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
          fillColor: backgroundColor ?? Colors.transparent,
          filled: true,
          hintStyle: TextStyle(
              fontFamily: "Roboto%s".format([robotoType ?? "Regular"]),
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: hintColor ?? textColor)),
    ));
  }
}

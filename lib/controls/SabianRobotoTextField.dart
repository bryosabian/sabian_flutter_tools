import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';
import 'package:sabian_tools/themes/SabianColorScheme.dart';

class SabianRobotoTextField extends StatefulWidget {
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

  final TextStyle? textStyle;

  final bool isPassword;

  final String? passwordCharacter;

  ///Focus node
  final FocusNode? focusNode;

  final bool autoCorrect;

  final bool enableSuggestions;

  final BorderRadiusGeometry? borderRadius;

  final bool allowPasswordVisibleToggle;

  final double? passwordVisibleToggleIconSize;

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
      this.enabled,
      this.onChanged,
      this.onEditingComplete,
      this.onSubmitted,
      this.maxLines,
      this.focusNode,
      this.showCloseKeyBoardAction = true,
      this.closeKeyBoardActionTitle,
      this.keyBoardActionBgColor,
      this.textStyle,
      this.onKeyBoardActionBgColor,
      this.textInputAction,
      this.isPassword = false,
      this.passwordCharacter,
      this.autoCorrect = true,
      this.enableSuggestions = true,
      this.borderRadius,
      this.allowPasswordVisibleToggle = false,
      this.passwordVisibleToggleIconSize})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SabianRobotoTextFieldState();
  }
}

class _SabianRobotoTextFieldState extends State<SabianRobotoTextField> {
  FocusNode? focusNode;
  bool showPassword = false;

  bool get wasShowPassword => widget.isPassword == true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    showPassword = wasShowPassword;
  }

  Widget _getField(BuildContext context) {
    TextEditingController? newController;

    if (widget.controller == null && widget.text != null) {
      newController = TextEditingController(text: widget.text);
    }

    Color bgColor = widget.backgroundColor ?? Colors.transparent;

    //Always wrap TextField in a material widget
    return Material(
        color: bgColor,
        borderRadius: widget.borderRadius,
        child: Center(
            child: TextField(
          maxLines: (wasShowPassword) ? 1 : widget.maxLines,
          obscureText: showPassword,
          obscuringCharacter: widget.passwordCharacter ?? ".",
          focusNode: focusNode,
          enabled: widget.enabled,
          controller: widget.controller ?? newController,
          textAlign: widget.textAlign ?? TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          textInputAction: widget.textInputAction,
          keyboardType: (wasShowPassword) ? TextInputType.text : widget.inputType,
          onChanged: widget.onChanged,
          autocorrect: !wasShowPassword && widget.autoCorrect,
          enableSuggestions: !wasShowPassword && widget.enableSuggestions,
          onEditingComplete: (widget.onEditingComplete != null)
              ? () {
                  focusNode!.unfocus();
                  widget.onEditingComplete!();
                }
              : null,
          onSubmitted: widget.onSubmitted,
          style: TextStyle(
            color: widget.textColor ?? widget.textStyle?.color,
            fontSize: widget.fontSize ?? widget.textStyle?.fontSize,
            fontWeight: widget.fontWeight ?? widget.textStyle?.fontWeight,
            fontFamily: "Roboto%s".format([widget.robotoType ?? "Regular"]),
          ),
          decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: widget.contentPadding,
              focusColor: widget.focusColor ?? Colors.transparent,
              prefixIcon: widget.prefixIcon,
              prefixIconColor: widget.prefixIconColor ?? widget.iconColor,
              suffixIcon: widget.suffixIcon ??
                  ((wasShowPassword && widget.allowPasswordVisibleToggle)
                      ? _passwordToggle(context)
                      : null),
              suffixIconColor: widget.suffixIconColor ?? widget.iconColor,
              iconColor: widget.iconColor,
              hintText: widget.hint,
              hintTextDirection: widget.direction,
              border: widget.border,
              disabledBorder: widget.disabledBorder ?? widget.border,
              focusedBorder: widget.focusedBorder ?? widget.border,
              enabledBorder: widget.border,
              fillColor: Colors.transparent,
              filled: true,
              hintStyle: TextStyle(
                  backgroundColor: Colors.transparent,
                  fontFamily:
                      "Roboto%s".format([widget.robotoType ?? "Regular"]),
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight,
                  color: widget.hintColor ?? widget.textColor)),
        )));
  }

  @protected
  Widget getBody(BuildContext context) {
    if (!widget.showCloseKeyBoardAction) {
      return _getField(context);
    }
    return KeyboardActions(
        disableScroll: true,
        config: _getKeyboardActions(context),
        child: _getField(context));
  }

  @override
  Widget build(BuildContext context) {
    return getBody(context);
  }

  KeyboardActionsConfig _getKeyboardActions(BuildContext context) {
    SabianColorScheme sabianColorScheme = SabianColorScheme(context);

    Color? actionTextColor = widget.onKeyBoardActionBgColor ??
        (sabianColorScheme.sabianTheme?.onKeyBoardButtonColor ??
            sabianColorScheme.defaultScheme.onBackground);

    Color? actionColor = widget.keyBoardActionBgColor ??
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
                    child: SabianRobotoText(
                        widget.closeKeyBoardActionTitle ?? "Close",
                        textColor: actionTextColor),
                  ),
                );
              },
            ],
          ),
        ]);
  }

  Widget _passwordToggle(BuildContext context) {
    final iconSize = widget.passwordVisibleToggleIconSize ?? 17;
    final parentSize = iconSize + 1;
    return GestureDetector(
        onTap: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        child: SizedBox(
            height: parentSize,
            width: parentSize,
            child: Center(
              child: FaIcon(
                (showPassword)
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash,
                color: widget.suffixIconColor ??
                    (widget.iconColor ?? widget.textColor),
                size: iconSize,
              ),
            )));
  }
}

import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianButton.dart';
import 'package:sabian_tools/modals/list/ListModalItem.dart';

class SabianBootstrapButton extends SabianButton {
  final IconData? leftIcon;
  final ListIconType? leftIconType;
  final IconData? rightIcon;
  final ListIconType? rightIconType;
  final Color? iconColor;
  final double? iconSize;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? innerPadding;

  bool get hasAnyIcon => leftIcon != null || rightIcon != null;

  Color? get iconColorOrDefault => iconColor ?? textColor;

  double? get iconSizeOrDefault => iconSize ?? fontSize;

  Color? get borderColorOrDefault => borderColor ?? backgroundColor;

  BorderRadius get borderRadiusOrDefault =>
      borderRadius ?? BorderRadius.circular(8);

  const SabianBootstrapButton(String text,
      {Key? key,
      super.onPressed,
      super.textColor,
      super.backgroundColor,
      super.pressedTextColor,
      super.pressedBackgroundColor,
      super.fontSize,
      super.robotoType,
      super.fontWeight,
      this.width,
      this.height,
      this.innerPadding,
      this.leftIcon,
      this.leftIconType = ListIconType.system,
      this.rightIcon,
      this.rightIconType = ListIconType.system,
      super.borderRadius,
      this.iconColor,
      this.iconSize,
      super.borderColor,
      super.borderWidth})
      : super(key: key, text: text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final styleBgColor = buttonStyle?.backgroundColor?.resolve({});

    Decoration decor = BoxDecoration(
        color: backgroundColor ?? (styleBgColor ?? scheme.primary),
        borderRadius: borderRadiusOrDefault,
        border: Border.all(
            width: borderWidth ?? 1.0,
            color: borderColorOrDefault ?? (styleBgColor ?? scheme.primary)));

    return GestureDetector(
        onTap: onPressed,
        child: Container(
            width: width,
            height: height,
            padding: innerPadding ??
                const EdgeInsetsDirectional.symmetric(
                    horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: (hasAnyIcon)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                if (leftIcon != null) _getLeftIcon(context),
                Flexible(child: Center(child: getText(context)), flex: 1),
                if (rightIcon != null) _getRightIcon(context)
              ],
            ),
            decoration: decor));
  }

  Widget _getLeftIcon(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final styleIconColor = buttonStyle?.iconColor?.resolve({}) ??
        buttonStyle?.textStyle?.resolve({})?.color;
    final type = leftIconType ?? ListIconType.system;
    return type.toIcon(
        leftIcon!,
        iconColorOrDefault ?? (styleIconColor ?? scheme.onPrimary),
        iconSizeOrDefault);
  }

  Widget _getRightIcon(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final styleIconColor = buttonStyle?.iconColor?.resolve({}) ??
        buttonStyle?.textStyle?.resolve({})?.color;
    final type = rightIconType ?? ListIconType.system;
    return type.toIcon(
        rightIcon!,
        iconColorOrDefault ?? (styleIconColor ?? scheme.onPrimary),
        iconSizeOrDefault);
  }

  Widget _wrappedSizedIcon(BuildContext context, Widget icon) {
    return SizedBox(
        width: iconSizeOrDefault, height: iconSizeOrDefault, child: icon);
  }
}

import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianButton.dart';
import 'package:sabian_tools/modals/list/ListModalItem.dart';
import 'package:sabian_tools/utils/utils.dart';

class SabianBootstrapButton extends SabianButton {
  final BorderRadius? borderRadius;
  final IconData? leftIcon;
  final ListIconType? leftIconType;
  final IconData? rightIcon;
  final ListIconType? rightIconType;
  final Color? iconColor;
  final double? iconSize;
  final Color? borderColor;

  bool get hasAnyIcon => leftIcon != null || rightIcon != null;

  Color? get iconColorOrDefault => iconColor ?? textColor;

  double? get iconSizeOrDefault => iconSize ?? fontSize;

  Color? get borderColorOrDefault => borderColor ?? backgroundColor;

  BorderRadius get borderRadiusOrDefault =>
      borderRadius ?? BorderRadius.circular(8);

  const SabianBootstrapButton(String text,
      {Key? key,
      Function()? onPressed,
      Color? textColor,
      Color? backgroundColor,
      Color? pressedTextColor,
      Color? pressedBackgroundColor,
      double? fontSize,
      String? robotoType,
      FontWeight? fontWeight,
      this.leftIcon,
      this.leftIconType = ListIconType.system,
      this.rightIcon,
      this.rightIconType = ListIconType.system,
      this.borderRadius,
      this.iconColor,
      this.iconSize,
      this.borderColor})
      : super(
            key: key,
            text: text,
            onPressed: onPressed,
            textColor: textColor,
            backgroundColor: backgroundColor,
            pressedTextColor: pressedTextColor,
            pressedBackgroundColor: pressedBackgroundColor,
            fontSize: fontSize,
            robotoType: robotoType,
            fontWeight: fontWeight);

  @override
  Widget build(BuildContext context) {
    Decoration decor = BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadiusOrDefault,
        border: Border.all(color: borderColorOrDefault!));

    return GestureDetector(
        onTap: onPressed,
        child: Container(
            padding: const EdgeInsetsDirectional.symmetric(
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
    final type = leftIconType ?? ListIconType.system;
    return type.toIcon(leftIcon!, iconColorOrDefault, iconSizeOrDefault);
  }

  Widget _getRightIcon(BuildContext context) {
    final type = rightIconType ?? ListIconType.system;
    return type.toIcon(rightIcon!, iconColorOrDefault, iconSizeOrDefault);
  }

  Widget _wrappedSizedIcon(BuildContext context, Widget icon) {
    return SizedBox(
        width: iconSizeOrDefault, height: iconSizeOrDefault, child: icon);
  }
}

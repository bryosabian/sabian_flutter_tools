import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';

class SabianButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  final Color? pressedTextColor;
  final Color? pressedBackgroundColor;

  final double? fontSize;
  final String? robotoType;
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;
  final ButtonStyle? buttonStyle;
  final Color? borderColor;
  final double? borderWidth;

  final Function()? onPressed;

  const SabianButton(
      {Key? key,
      required this.text,
      this.onPressed,
      this.textColor,
      this.backgroundColor,
      this.pressedTextColor,
      this.pressedBackgroundColor,
      this.fontSize,
      this.robotoType,
      this.fontWeight,
      this.borderRadius,
      this.buttonStyle,
      this.borderColor,
      this.borderWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    MaterialStateProperty<Color?>? bgColor;

    if (pressedBackgroundColor != null || backgroundColor != null) {
      bgColor = MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return (pressedBackgroundColor ?? backgroundColor) ?? scheme.primary;
        }
        return backgroundColor ?? scheme.primary;
      });
    } else if (buttonStyle?.backgroundColor != null) {
      bgColor = buttonStyle!.backgroundColor;
    }

    return TextButton(
        onPressed: onPressed,
        child: getText(context),
        style: ButtonStyle(
            shape: (borderRadius == null)
                ? null
                : MaterialStateProperty.resolveWith((states) {
                    return RoundedRectangleBorder(
                        borderRadius: borderRadius!,
                        side: borderColor != null
                            ? BorderSide(
                                color: borderColor ?? scheme.primary,
                                width: borderWidth ?? 1.0)
                            : BorderSide.none);
                  }),
            backgroundColor: bgColor));
  }

  @protected
  Widget getText(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return SabianRobotoText(text,
        textColor: textColor ?? scheme.onPrimary,
        fontSize: fontSize ?? theme.textTheme.labelLarge?.fontSize,
        type: robotoType ?? "Regular",
        fontWeight: fontWeight ?? theme.textTheme.labelLarge?.fontWeight);
  }
}

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
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: SabianRobotoText(
            text,
            textColor: textColor,
            fontSize: fontSize,
            type: robotoType ?? "Regular",
            fontWeight: fontWeight),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return pressedBackgroundColor ?? backgroundColor;
          }
          return backgroundColor;
        })));
  }
}

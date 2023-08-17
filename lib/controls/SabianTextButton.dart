import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianButton.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';

class SabianTextButton extends SabianButton {
  const SabianTextButton(String text,
      {Key? key,
      Function()? onPressed,
      Color? textColor,
      Color? backgroundColor,
      Color? pressedTextColor,
      Color? pressedBackgroundColor,
      double? fontSize,
      String? robotoType,
      FontWeight? fontWeight})
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
    return TextButton(
        child: Text(text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight ?? FontWeight.bold,
              fontFamily: "Roboto%s".format([robotoType]),
            )),
        style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith((states) {
            return EdgeInsets.zero;
          }),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return pressedBackgroundColor ?? backgroundColor;
            }
            return backgroundColor;
          }),
        ),
        onPressed: onPressed);
  }
}

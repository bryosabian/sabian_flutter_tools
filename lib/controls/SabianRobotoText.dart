import 'package:flutter/material.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';

class SabianRobotoText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String type;
  final TextOverflow? overflow;
  final TextAlign? align;

  const SabianRobotoText(this.text,
      {Key? key,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.type = "Regular",
      this.overflow,
      this.align
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          overflow: overflow,
          decoration: TextDecoration.none,
          color: textColor,
          backgroundColor: null,
          fontFamily: "Roboto%s".format([type]),
          fontSize: fontSize,
          fontWeight: fontWeight,
          package: "sabian_tools",
      ),
    );
  }
}

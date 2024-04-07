import 'package:flutter/material.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';

class SabianRobotoText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  /// The type without Roboto- prefix
  final String type;
  final TextOverflow? overflow;
  final TextAlign? align;
  final bool? softwrap;
  final int? maxLines;

  const SabianRobotoText(this.text,
      {Key? key,
      this.textColor,
      this.fontSize,
      this.fontWeight,

      /// The type without Roboto- prefix
      this.type = "Regular",
      this.overflow,
      this.align,
        this.maxLines,
      this.softwrap = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getBody(context);
  }

  @protected
  Widget getBody(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      softWrap: softwrap,
      maxLines: maxLines,
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

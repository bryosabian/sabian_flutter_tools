import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';

class SabianWrappedRobotoText extends SabianRobotoText {

  const SabianWrappedRobotoText(String text,
      {Key? key,
      Color? textColor,
      double? fontSize,
      FontWeight? fontWeight,

      /// The type without Roboto- prefix
      String type = "Regular",
      TextOverflow? overflow,
      TextAlign? align,
      bool? softwrap = true})
      : super(text,
            key: key,
            textColor: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
            type: type,
            overflow: overflow,
            align: align,
            softwrap: softwrap);

  @override
  Widget getBody(BuildContext context) {
    return Flexible(child: super.getBody(context));
  }
}

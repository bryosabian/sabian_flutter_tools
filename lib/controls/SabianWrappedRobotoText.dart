import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';

class SabianWrappedRobotoText extends SabianRobotoText {
  /// Whether the parent supports flexible. Such parents would include row, column or flex containers
  final bool isParentFlexible;

  const SabianWrappedRobotoText(String text,
      {Key? key,
      Color? textColor,
      double? fontSize,
      FontWeight? fontWeight,

      /// The type without Roboto- prefix
      String type = "Regular",
      TextOverflow? overflow,
      TextAlign? align,
      bool? softwrap = true,
      this.isParentFlexible = true})
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
    Widget widget = Flexible(child: super.getBody(context));
    if (isParentFlexible == true) {
      return widget;
    }
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [widget]);
  }
}

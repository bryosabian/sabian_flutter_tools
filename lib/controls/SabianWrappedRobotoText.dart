import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';

class SabianWrappedRobotoText extends SabianRobotoText {
  /// Whether the parent supports flexible. Such parents would include row, column or flex containers
  final bool isParentFlexible;

  const SabianWrappedRobotoText(String text,
      {Key? key,
      super.textColor,
      super.fontSize,
      super.fontWeight,

      /// The type without Roboto- prefix
      super.type = "Regular",
      super.overflow,
      super.align,
      super.textStyle,
      super.softwrap = true,
      super.maxLines,
      super.textDecoration,
      this.isParentFlexible = true})
      : super(text, key: key);

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

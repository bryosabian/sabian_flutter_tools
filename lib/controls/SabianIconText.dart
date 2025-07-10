import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianIcon.dart';
import 'package:sabian_tools/controls/SabianWrappedRobotoText.dart';
import 'package:sabian_tools/modals/list/ListModalItem.dart';

class SabianIconText extends StatelessWidget {
  final IconData icon;
  final ListIconType iconType;
  final Color? iconColor;
  final Color? textColor;
  final String text;
  final String? robotoType;
  final IconAlign iconAlign;
  final EdgeInsets space;
  final double? iconSize;
  final double? textSize;
  final double? textIconSize;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;
  static const double _defaultFontSize = 14;

  const SabianIconText(this.text, this.icon,
      {super.key,
      this.iconType = ListIconType.system,
      this.iconColor,
      this.textColor,
      this.robotoType,
      this.iconAlign = IconAlign.left,
      this.space = const EdgeInsets.symmetric(horizontal: 5),
      this.iconSize,
      this.textSize,
      this.textIconSize,
      this.fontWeight,
      this.textStyle
      });

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.only(
        left: iconAlign == IconAlign.left ? space.left : 0,
        right: iconAlign == IconAlign.right ? space.right : 0);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (iconAlign == IconAlign.left) _icon(context),
        Container(padding: padding, child: _text(context)),
        if (iconAlign == IconAlign.right) _icon(context)
      ],
    );
  }

  Widget _icon(BuildContext context) {
    double size = iconSize ?? (textIconSize ?? _defaultFontSize);
    return SabianIcon(
      icon,
      iconType: iconType,
      size: size,
      color: iconColor ?? textColor,
    );
  }

  Widget _text(BuildContext context) {
    return SabianWrappedRobotoText(
      text,
      type: robotoType ?? "Regular",
      isParentFlexible: false,
      textColor: textColor,
      fontSize: textSize ?? _defaultFontSize,
      fontWeight: fontWeight,
      textStyle: textStyle,
    );
  }
}

enum IconAlign {
  left,
  right;
}

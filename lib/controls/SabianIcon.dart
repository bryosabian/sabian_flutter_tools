import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabian_tools/modals/list/ListModalItem.dart';

class SabianIcon extends StatelessWidget {
  final ListIconType iconType;
  final IconData icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (iconType == ListIconType.fontAwesome) {
      return FaIcon(
        icon,
        size: size,
        color: color,
      );
    }
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }

  const SabianIcon(
    this.icon, {
    super.key,
    this.iconType = ListIconType.system,
    this.size,
    this.color,
  });
}

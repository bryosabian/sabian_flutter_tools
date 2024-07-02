import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';
import 'package:sabian_tools/controls/bottomMenu/BottomMenuItemWidget.dart';
import 'package:badges/badges.dart' as badge;
import 'package:sabian_tools/controls/utils.dart';
import 'package:sabian_tools/themes/SabianThemeExtension.dart';

class BottomMenuItemHorizontalWidget extends BottomMenuItemWidget {
  final EdgeInsets? padding;

  const BottomMenuItemHorizontalWidget(
      {super.key,
      this.padding,
      required super.item,
      super.index,
      super.onItemSelected,
      super.isSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sTheme = theme.extension<SabianThemeExtension>();
    return Padding(
            padding: padding ?? const EdgeInsets.all(20),
            child: (item.hasNotificationCounter)
                ? badge.Badge(
                    child: _body(context),
                    badgeContent: SabianRobotoText(
                        textColor: sTheme?.onNotificationInfoColor ??
                            theme.colorScheme.onError,
                        item.notificationCounter.toString(),
                        fontSize: 10))
                : _body(context));
  }

  Widget _body(BuildContext context) {
    final colors = getColors(context);
    final textColor = colors["textColor"];
    final iconColor = colors["iconColor"];
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon(iconColor),
        sabianHorizontalSpacer(width: 5),
        SabianRobotoText(
          item.title!,
          textColor: textColor,
          fontSize: 14,
        ),
      ],
    );
  }
}

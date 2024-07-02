import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';
import 'package:sabian_tools/controls/bottomMenu/BottomMenuItem.dart';
import 'package:sabian_tools/controls/utils.dart';
import 'package:sabian_tools/themes/SabianThemeExtension.dart';

class BottomMenuItemWidget extends StatelessWidget {
  final BottomMenuItem item;
  final int? index;
  final Function(BottomMenuItem, int?)? onItemSelected;
  final bool? isSelected;

  const BottomMenuItemWidget(
      {Key? key,
      required this.item,
      this.index,
      this.onItemSelected,
      this.isSelected})
      : super(key: key);

  @protected
  Map<String, Color?> getColors(BuildContext context) {
    final theme = Theme.of(context).extension<SabianThemeExtension>();
    var textColor = item.menuTextColor ?? theme?.bottomMenuItemTextColor;
    var iconColor =
        (item.menuIconColor ?? theme?.bottomMenuItemIconColor) ?? textColor;
    if (isSelected == true) {
      textColor = (item.currentMenuTextColor ??
              theme?.currentBottomMenuItemTextColor) ??
          textColor;
      iconColor = (item.currentMenuIconColor ?? item.currentMenuTextColor) ??
          theme?.currentBottomMenuItemIconColor ??
          iconColor;
    }
    return <String, Color?>{"textColor": textColor, "iconColor": iconColor};
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sTheme = theme.extension<SabianThemeExtension>();
    final colors = getColors(context);
    final textColor = colors["textColor"];
    final iconColor = colors["iconColor"];
    return GestureDetector(
        onTap: () {
          if (item.onMenuItemSelectListener != null) {
            item.onMenuItemSelectListener!.call(item, index);
          } else if (onItemSelected != null) {
            onItemSelected!(item, index);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
                child: (item.hasNotificationCounter)
                    ? badge.Badge(
                        child: icon(iconColor),
                        badgeContent: SabianRobotoText(
                            item.notificationCounter.toString(),
                            textColor: sTheme?.onNotificationInfoColor ??
                                theme.colorScheme.onError,
                            fontSize: 10))
                    : icon(iconColor)),
            sabianVerticalSpacer(height: 1),
            Center(
                child: SabianRobotoText(
              item.title!,
              textColor: textColor,
              fontSize: 14,
            )),
          ],
        ));
  }

  @protected
  Widget icon(Color? iconColor) {
    return Icon(
      item.icon,
      size: 20,
      color: iconColor,
    );
  }
}

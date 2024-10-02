import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/menus/SabianAppMenuItem.dart';
import 'package:sabian_tools/controls/menus/bottomMenu/BottomMenuItem.dart';
import 'package:sabian_tools/controls/menus/bottomMenu/BottomMenuItemHorizontalWidget.dart';
import 'package:sabian_tools/modals/list/ListModalItem.dart';

class SabianPopUpMenu {
  final Color? popUpColor;
  final Color? onPopUpColor;
  final Color? popUpDividerColor;

  SabianPopUpMenu({
    this.popUpColor,
    this.onPopUpColor,
    this.popUpDividerColor,
  });

  void show(BuildContext context, List<SabianAppMenuItem> list) {
    final theme = Theme.of(context);
    list.sort();
    showModalBottomSheet(
      context: context,
      backgroundColor: popUpColor,
      builder: (context) {
        return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                  height: 1, color: popUpDividerColor ?? theme.dividerColor),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      item.onMenuSelectListener?.call(item);
                      Navigator.pop(context);
                    },
                    child: BottomMenuItemHorizontalWidget(
                        key: Key("SabianPopUpBottomMenuItemWidget$index"),
                        item: BottomMenuItem(
                            title: item.title,
                            icon: item.icon,
                            menuTextColor: onPopUpColor,
                            notificationCounter: item.notificationCounter,
                            position: item.order ?? 0,
                            iconType: item.iconType ?? ListIconType.system),
                        index: index,
                        isSelected: false));
              },
            ));
      },
    );
  }
}

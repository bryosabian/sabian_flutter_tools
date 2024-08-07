import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/bottomMenu/BottomMenuItem.dart';
import 'package:sabian_tools/controls/bottomMenu/BottomMenuItemHorizontalWidget.dart';
import 'package:sabian_tools/controls/bottomMenu/BottomMenuItemWidget.dart';
import 'package:sabian_tools/extensions/Lists+Sabian.dart';
import 'package:sabian_tools/themes/SabianThemeExtension.dart';

class BottomMenu extends StatelessWidget {
  final List<BottomMenuItem> items;
  final int? selectedIndex;
  final int maxItems;
  final Function(int)? onItemSelected;
  final String? extraMenuTitle;
  final IconData? moreIcon;
  final double? menuHeight;

  final List<BottomMenuItem> _minimumItems = [];
  final List<BottomMenuItem> _extraItems = [];
  bool _hasExtraMenu = false;

  BottomMenu(
      {Key? key,
      required this.items,
      this.selectedIndex,
      this.onItemSelected,
      this.extraMenuTitle,
      this.moreIcon,
      this.maxItems = 4,
      this.menuHeight})
      : super(key: key);

  void _populateMenuList(BuildContext context) {
    _minimumItems.clear();
    _extraItems.clear();
    items.sort((a, b) => a.position.compareTo(b.position));
    _hasExtraMenu = items.length > maxItems;
    if (_hasExtraMenu) {
      List<List<BottomMenuItem>> groupedMenuList = items.chunked(maxItems - 1);
      _minimumItems.addAll(groupedMenuList.first);
      groupedMenuList.removeAt(0);
      for (var group in groupedMenuList) {
        _extraItems.addAll(group);
      }
      _minimumItems.add(BottomMenuItem.withTitleAndIcon(
          extraMenuTitle ?? "More", moreIcon ?? Icons.menu)
        ..id = "SabianMoreBro"
        ..hasNotification =
            _extraItems.any((item) => item.hasNotificationCounter)
        ..notificationCounter = _extraItems.fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.notificationCounter ?? 0))
        ..onMenuItemSelectListener = (_, __) => _showExtraMenu(context));
    } else {
      _minimumItems.addAll(items);
    }
  }

  @override
  Widget build(BuildContext context) {
    _populateMenuList(context);
    final theme = Theme.of(context);
    final sTheme = theme.extension<SabianThemeExtension>();
    final height = (menuHeight ?? sTheme?.bottomMenuHeight) ?? 60.0;
    return SizedBox(
        height: height + 1,
        child: Column(children: [
          Divider(
              height: 1,
              color: sTheme?.bottomMenuDividerColor ?? theme.dividerColor),
          SizedBox(
              height: height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _minimumItems
                    .mappedByIndex((item, idx) => Center(
                        child: BottomMenuItemWidget(
                            item: item,
                            key: Key("SabianBottomMenuItemWidget$idx"),
                            index: idx,
                            isSelected: selectedIndex == idx,
                            onItemSelected: _onItemSelected)))
                    .toList(),
              ))
        ]));
  }

  void _onItemSelected(BottomMenuItem item, int? index) {
    if (onItemSelected != null) {
      onItemSelected!(index!);
    }
  }

  void _showExtraMenu(BuildContext context) {
    final theme = Theme.of(context);
    final sabianTheme = theme.extension<SabianThemeExtension>();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: sabianTheme?.bottomMenuDividerColor ??
                      theme.dividerColor),
              itemCount: _extraItems.length,
              itemBuilder: (context, index) {
                final itemIndex = index + (_minimumItems.length - 1);
                final item = items[itemIndex];
                return GestureDetector(
                    onTap: () {
                      if (item.onMenuItemSelectListener != null) {
                        item.onMenuItemSelectListener!.call(item, index);
                      } else {
                        _onItemSelected(item, itemIndex);
                      }
                      Navigator.pop(context);
                    },
                    child: BottomMenuItemHorizontalWidget(
                        key: Key("SabianBottomMenuItemWidget$index"),
                        item: _extraItems[index],
                        index: itemIndex,
                        isSelected: selectedIndex == itemIndex));
              },
            ));
      },
    );
  }
}

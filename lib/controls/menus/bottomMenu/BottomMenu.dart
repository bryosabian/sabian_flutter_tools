import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/menus/bottomMenu/BottomMenuController.dart';
import 'package:sabian_tools/controls/menus/bottomMenu/BottomMenuItem.dart';
import 'package:sabian_tools/controls/menus/bottomMenu/BottomMenuItemHorizontalWidget.dart';
import 'package:sabian_tools/controls/menus/bottomMenu/BottomMenuItemWidget.dart';
import 'package:sabian_tools/extensions/Lists+Sabian.dart';
import 'package:sabian_tools/themes/SabianThemeExtension.dart';

class BottomMenu extends StatefulWidget {
  final List<BottomMenuItem> items;
  final int? selectedIndex;
  final int maxItems;
  final Function(int)? onItemSelected;
  final String? extraMenuTitle;
  final IconData? moreIcon;
  final double? menuHeight;
  final BottomMenuController? controller;

  const BottomMenu(
      {Key? key,
      required this.items,
      this.selectedIndex,
      this.onItemSelected,
      this.extraMenuTitle,
      this.moreIcon,
      this.maxItems = 4,
      this.controller,
      this.menuHeight})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BottomMenu();
  }
}

class _BottomMenu extends State<BottomMenu> {
  BottomMenuController? get controller => widget.controller;

  late List<BottomMenuItem> items;

  int? get selectedIndex => widget.selectedIndex;

  int get maxItems => widget.maxItems;

  Function(int)? get onItemSelected => widget.onItemSelected;

  String? get extraMenuTitle => widget.extraMenuTitle;

  IconData? get moreIcon => widget.moreIcon;

  double? get menuHeight => widget.menuHeight;

  final List<BottomMenuItem> _minimumItems = [];

  final List<BottomMenuItem> _extraItems = [];

  bool _hasExtraMenu = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = widget.items;
  }

  void _populateMenuList() {
    _minimumItems.clear();
    _extraItems.clear();
    items.sort((a, b) => a.requirePosition.compareTo(b.requirePosition));
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
        ..notificationCounter = _extraItems.fold<int>(
            0,
            (previousValue, element) =>
                previousValue + (element.notificationCounter ?? 0))
        ..onMenuItemSelectListener = (_, __) => _showExtraMenu(context));
    } else {
      _minimumItems.addAll(items);
    }
    controller?.init(items, _onMenusUpdated);
  }

  void _onMenusUpdated(List<BottomMenuItem> items) {
    setState(() {
      this.items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    _populateMenuList();
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
                    behavior: HitTestBehavior.opaque,
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

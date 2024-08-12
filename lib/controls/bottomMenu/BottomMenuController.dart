import 'package:sabian_tools/controls/bottomMenu/BottomMenuItem.dart';

class BottomMenuController {
  Function(List<BottomMenuItem>)? onMenusUpdated;

  late List<BottomMenuItem> items;

  ///Should be called from child widget
  void init(List<BottomMenuItem> items,
      Function(List<BottomMenuItem>)? onMenusUpdated) {
    this.items = items;
    this.onMenusUpdated = onMenusUpdated;
  }

  void refreshMenus(List<BottomMenuItem> newMenus) {
    onMenusUpdated?.call(newMenus);
  }

  void refreshCurrentMenus() {
    refreshMenus(items);
  }

  void clearMenus() {
    refreshMenus([]);
  }

  void setCurrentMenuID(String id, {BottomMenuItem? item}) {
    var currIndex = _getMenuIndex(id);
    if (currIndex == -1) {
      if (item != null) {
        item.id = id;
        items.add(item);
        setCurrentMenuID(id);
        return;
      }
      return;
    }
    resetCurrentMenu(notify: false);
    final hm = items[currIndex];
    hm.setCurrent();
    updateMenu(id, hm, index: currIndex);
  }

  void resetCurrentMenu({bool notify = true}) {
    for (BottomMenuItem item in items) {
      if (item.isCurrent == true) {
        item.isCurrent = false;
      }
    }
    if (notify) refreshCurrentMenus();
  }

  bool updateMenu(String id, BottomMenuItem newItem, {int? index}) {
    int idx;
    if (index == null) {
      idx = _getMenuIndex(id);
      if (idx <= -1) {
        return false;
      }
    } else {
      idx = index;
    }
    var oldItem = items[idx];
    newItem.copyChangesTo(oldItem);
    items[idx] = oldItem;
    refreshCurrentMenus();
    return true;
  }

  bool updateNotificationCounter(String id, int counter) {
    final idx = _getMenuIndex(id);
    if (idx <= -1) {
      return false;
    }
    final item = items[idx];
    item.notificationCounter = counter;
    return updateMenu(id, item, index: idx);
  }

  bool deleteMenu(String id, {bool notify = true}) {
    final idx = _getMenuIndex(id);
    if (idx <= -1) {
      return false;
    }
    items.removeAt(idx);
    if (notify) {
      refreshCurrentMenus();
    }
    return true;
  }

  void deleteMenuItems(Map<String, BottomMenuItem> items) {
    final list = items.entries;
    for (var entry in list) {
      deleteMenu(entry.key, notify: false);
    }
    refreshCurrentMenus();
  }

  void addMenuItems(Map<String, BottomMenuItem> items) {
    final list = items.entries;
    for (var entry in list) {
      addMenuItem(entry.value, notify: false);
    }
    refreshCurrentMenus();
  }

  void addMenuItem(BottomMenuItem item, {bool notify = true}) {
    items.add(item);
    if (notify) {
      refreshCurrentMenus();
    }
  }

  void addMenuItemAtPosition(int position, BottomMenuItem item,
      {bool notify = true}) {
    items.insert(position, item);
    if (notify) {
      refreshMenus(items);
    }
  }

  int _getMenuIndex(String id) {
    var item = BottomMenuItem.withId(id);
    var idx = items.indexOf(item);
    return idx;
  }
}

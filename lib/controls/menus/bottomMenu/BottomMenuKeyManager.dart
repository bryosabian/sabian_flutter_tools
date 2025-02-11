import 'package:sabian_tools/controls/menus/bottomMenu/BottomMenuItem.dart';

class BottomMenuKeyManager {
  final Map<String, void Function(BottomMenuItem)> _menuKeys = {};

  void registerMenuKey(String key, void Function(BottomMenuItem) action) {
    _menuKeys[key] = action;
  }

  void registerMenuKeys(Map<String, void Function(BottomMenuItem)> map) {
    _menuKeys.addAll(map);
  }

  void executeMenuKey(String key, BottomMenuItem item) {
    final action = _menuKeys[key];
    if (action != null) {
      action(item);
    }
  }
}

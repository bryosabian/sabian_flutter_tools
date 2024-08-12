import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sabian_tools/modals/list/ListModalItem.dart';

class BottomMenuItem {
  String? title;
  String? image;

  IconData? icon;

  ListIconType iconType = ListIconType.system;

  Color? menuIconColor;
  Color? menuTextColor;

  Color? currentMenuIconColor;
  Color? currentMenuTextColor;

  OnMenuItemSelectListener? onMenuItemSelectListener;
  String? id;

  bool get hasNotificationCounter =>
      notificationCounter != null && notificationCounter! > 0;

  int? notificationCounter;

  bool? animateNotificationCounter = false;

  int position = 0;

  bool? isCurrent;

  void setCurrent() {
    isCurrent = true;
  }

  BottomMenuItem.withId(this.id);

  BottomMenuItem.withTitleAndIcon(this.title, this.icon) {
    id = title;
  }

  BottomMenuItem.withTitleIconAndListener(
      this.title, this.icon, this.onMenuItemSelectListener) {
    id = title;
  }

  void copyChangesTo(BottomMenuItem oldItem) {
    if (title != null) {
      oldItem.title = title;
    }
    if (image != null) {
      oldItem.image = image;
    }
    if (icon != null) {
      oldItem.icon = icon;
    }
    if (onMenuItemSelectListener != null) {
      oldItem.onMenuItemSelectListener = onMenuItemSelectListener;
    }
    if (animateNotificationCounter == true) {
      oldItem.animateNotificationCounter = animateNotificationCounter;
    }
    if (position != null) {
      oldItem.position = position;
    }
    if (notificationCounter != null) {
      oldItem.notificationCounter = notificationCounter;
    }
    if (menuIconColor != null) {
      oldItem.menuIconColor = menuIconColor;
    }
    if (menuTextColor != null) {
      oldItem.menuTextColor = menuTextColor;
    }
    if (isCurrent != null) {
      oldItem.isCurrent = isCurrent;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BottomMenuItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  BottomMenuItem({
    this.title,
    this.image,
    this.icon,
    this.iconType = ListIconType.system,
    this.menuIconColor,
    this.menuTextColor,
    this.currentMenuIconColor,
    this.currentMenuTextColor,
    this.onMenuItemSelectListener,
    this.id,
    this.notificationCounter,
    this.animateNotificationCounter,
    this.position = 0,
    this.isCurrent,
  });
}

typedef OnMenuItemSelectListener = void Function(
    BottomMenuItem item, int? position);

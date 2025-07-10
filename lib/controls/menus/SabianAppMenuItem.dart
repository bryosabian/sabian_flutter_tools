import 'package:flutter/material.dart';
import 'package:sabian_tools/modals/list/ListModalItem.dart';

typedef OnMenuItemSelectListener = void Function(SabianAppMenuItem item);

class SabianAppMenuItem implements Comparable<SabianAppMenuItem> {
  static const String searchID =
      "menuSearcher"; // Replace with actual ID if available

  String? itemID;
  int? order;
  String? title;
  bool? showAsIcon;

  bool get canShowAsIcon => showAsIcon == true;

  IconData? icon;
  ListIconType? iconType;
  bool? isSearch;
  String? key;
  int? notificationCounter;

  bool get hasNotificationCounter =>
      notificationCounter != null && notificationCounter! > 0;

  OnMenuItemSelectListener? onMenuSelectListener;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SabianAppMenuItem) return false;
    return itemID == other.itemID;
  }

  @override
  int get hashCode => itemID!.hashCode;

  SabianAppMenuItem(
      {this.itemID,
        this.order = 10,
        this.title,
        this.showAsIcon,
        this.icon,
        this.iconType,
        this.isSearch,
        this.key,
        this.onMenuSelectListener,
        this.notificationCounter}) {
    if (isSearch == true) {
      showAsIcon = true;
    }
  }

  factory SabianAppMenuItem.copy(SabianAppMenuItem item) {
    return SabianAppMenuItem(
        itemID: item.itemID,
        order: item.order,
        title: item.title,
        showAsIcon: item.showAsIcon,
        icon: item.icon,
        iconType: item.iconType,
        isSearch: item.isSearch,
        key: item.key,
        onMenuSelectListener: item.onMenuSelectListener,
        notificationCounter: item.notificationCounter);
  }

  void copyChangesFrom(SabianAppMenuItem item) {
    itemID = item.itemID;
    order = item.order;
    title = item.title;
    showAsIcon = item.showAsIcon;
    icon = item.icon;
    iconType = item.iconType;
    isSearch = item.isSearch;
    key = item.key;
    onMenuSelectListener = item.onMenuSelectListener;
    notificationCounter = item.notificationCounter;
  }

  void copyChangesTo(SabianAppMenuItem item) {
    item.copyChangesFrom(this);
  }

  @override
  int compareTo(SabianAppMenuItem other) {
    return order?.compareTo(other.order ?? 0) ?? 0;
  }
}

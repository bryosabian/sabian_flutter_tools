import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListModalItem {
  late String title;
  late Object value;
  late int ID;
  IconData? icon;
  String? image;
  ListIconType iconType = ListIconType.system;
  ListImageIconType imageIconType = ListImageIconType.local;
  bool circleImageIcons = false;
  Size? iconSize;


  ListModalItem(this.title) {
    value = title;
    ID = title.hashCode;
  }

  ListModalItem.withAll({
    required this.title,
    required this.value,
    required this.ID,
    this.icon,
    this.image,
    this.iconType = ListIconType.system,
    this.imageIconType = ListImageIconType.local,
    this.circleImageIcons = false,
    this.iconSize,
  });

  ListModalItem.withValue(this.title, {required this.value}) {
    ID = title.hashCode;
  }

  ListModalItem.withID(this.title, {required this.ID}) {
    value = title;
  }

  ListModalItem setIconType(ListIconType type) {
    iconType = type;
    return this;
  }

  ListModalItem setImageIconType(ListImageIconType type) {
    imageIconType = type;
    return this;
  }

  ListModalItem setValue(Object value) {
    this.value = value;
    return this;
  }

  ListModalItem setRoundImageIcons(bool can) {
    circleImageIcons = can;
    return this;
  }

  ListModalItem setID(int ID) {
    this.ID = ID;
    return this;
  }

  ListModalItem setIconSize(Size size) {
    iconSize = size;
    return this;
  }

  ListModalItem setIcon(IconData icon, ListIconType type) {
    this.icon = icon;
    iconType = type;
    return this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListModalItem &&
          runtimeType == other.runtimeType &&
          ID == other.ID;

  @override
  int get hashCode => ID.hashCode;

  bool get hasAnyIcon => hasImageIcon || icon != null;

  bool get hasImageIcon => image != null && image!.isNotEmpty;

  @override
  String toString() {
    return title;
  }


}

enum ListIconType {
  system,
  fontAwesome;

  Widget toIcon(IconData data, Color? color, double? fontSize) {
    switch (this) {
      case ListIconType.system:
        return Icon(data, color: color, size: fontSize);
      case ListIconType.fontAwesome:
        return FaIcon(data, color: color, size: fontSize);
    }
  }
}

enum ListImageIconType { local, url }

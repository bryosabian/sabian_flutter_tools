import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sabian_tools/themes/SabianThemeExtension.dart';

class SabianSnackListItem {
  final Color? bgColor;
  final Color? textColor;
  final String? message;
  final bool? closeable;
  final String id;
  final SabianSnackListItemType? type;
  final void Function(SabianSnackListItem)? onClose;
  final void Function(SabianSnackListItem)? onSelect;
  final MapEntry<String, void Function(SabianSnackListItem)>? action;

  Color? finalBgColor(BuildContext context) {
    if (bgColor != null) {
      return bgColor!;
    }
    return type?.bgColor(context);
  }

  Color? finalTextColor(BuildContext context) {
    if (textColor != null) {
      return textColor!;
    }
    return type?.textColor(context);
  }

  const SabianSnackListItem(
      {this.bgColor,
      this.textColor,
      this.message,
      this.closeable,
      required this.id,
      this.onClose,
      this.type,
      this.onSelect,
      this.action});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is SabianSnackListItem && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

enum SabianSnackListItemType {
  success,
  danger,
  information;

  Color? bgColor(BuildContext context) {
    final theme = Theme.of(context);
    final sabianColor = theme.extension<SabianThemeExtension>();
    switch (this) {
      case SabianSnackListItemType.success:
        return sabianColor?.notificationSuccessColor;
      case SabianSnackListItemType.danger:
        return sabianColor?.notificationDangerColor;
      case SabianSnackListItemType.information:
        return sabianColor?.notificationInfoColor;
    }
  }

  Color? textColor(BuildContext context) {
    final theme = Theme.of(context);
    final sabianColor = theme.extension<SabianThemeExtension>();
    switch (this) {
      case SabianSnackListItemType.success:
        return sabianColor?.onNotificationSuccessColor;
      case SabianSnackListItemType.danger:
        return sabianColor?.onNotificationDangerColor;
      case SabianSnackListItemType.information:
        return sabianColor?.onNotificationInfoColor;
    }
  }
}

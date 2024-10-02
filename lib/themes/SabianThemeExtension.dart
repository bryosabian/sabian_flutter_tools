import 'package:flutter/material.dart';

@immutable
class SabianThemeExtension extends ThemeExtension<SabianThemeExtension> {
  final Color? dialogBackgroundColor;
  final Color? dialogTitleColor;
  final Color? dialogTextColor;
  final Color? dialogButtonColor;
  final Color? textFieldColor;

  final Color? notificationDangerColor;
  final Color? notificationSuccessColor;
  final Color? notificationErrorColor;
  final Color? notificationInfoColor;
  final Color? notificationInActiveColor;

  final Color? onNotificationDangerColor;
  final Color? onNotificationSuccessColor;
  final Color? onNotificationErrorColor;
  final Color? onNotificationInfoColor;
  final Color? onNotificationInActiveColor;

  final Color? keyBoardButtonColor;
  final Color? onKeyBoardButtonColor;

  final Color? bottomMenuItemTextColor;
  final Color? bottomMenuItemIconColor;

  final Color? currentBottomMenuItemTextColor;
  final Color? currentBottomMenuItemIconColor;

  final double? bottomMenuHeight;
  final Color? bottomMenuDividerColor;

  const SabianThemeExtension(
      {this.dialogBackgroundColor,
      this.dialogTitleColor,
      this.dialogTextColor,
      this.dialogButtonColor,
      this.textFieldColor,
      this.notificationDangerColor,
      this.notificationSuccessColor,
      this.notificationErrorColor,
      this.notificationInfoColor,
      this.notificationInActiveColor,
      this.onNotificationDangerColor,
      this.onNotificationSuccessColor,
      this.onNotificationErrorColor,
      this.onNotificationInfoColor,
      this.onNotificationInActiveColor,
      this.keyBoardButtonColor,
      this.onKeyBoardButtonColor,
      this.currentBottomMenuItemTextColor,
      this.currentBottomMenuItemIconColor,
      this.bottomMenuItemTextColor,
      this.bottomMenuItemIconColor,
      this.bottomMenuHeight,
      this.bottomMenuDividerColor});

  @override
  SabianThemeExtension copyWith(
      {Color? dialogBackgroundColor,
      Color? dialogTitleColor,
      Color? dialogTextColor,
      Color? dialogButtonColor,
      Color? textFieldColor,
      Color? notificationDangerColor,
      Color? notificationSuccessColor,
      Color? notificationErrorColor,
      Color? notificationInfoColor,
      Color? notificationInActiveColor,
      Color? onNotificationDangerColor,
      Color? onNotificationSuccessColor,
      Color? onNotificationErrorColor,
      Color? onNotificationInfoColor,
      Color? onNotificationInActiveColor,
      Color? keyBoardButtonColor,
      Color? onKeyBoardButtonColor,
      Color? bottomMenuItemTextColor,
      Color? bottomMenuItemIconColor,
      Color? currentBottomMenuItemTextColor,
      Color? currentBottomMenuItemIconColor,
      Color? bottomMenuDividerColor,
      double? bottomMenuHeight}) {
    return SabianThemeExtension(
        dialogBackgroundColor:
            dialogBackgroundColor ?? this.dialogBackgroundColor,
        dialogTitleColor: dialogTitleColor ?? this.dialogTitleColor,
        dialogTextColor: dialogTextColor ?? this.dialogTextColor,
        dialogButtonColor: dialogButtonColor ?? this.dialogButtonColor,
        textFieldColor: textFieldColor ?? this.textFieldColor,
        notificationDangerColor:
            notificationDangerColor ?? this.notificationDangerColor,
        notificationSuccessColor:
            notificationSuccessColor ?? this.notificationSuccessColor,
        notificationErrorColor:
            notificationErrorColor ?? this.notificationErrorColor,
        notificationInfoColor:
            notificationInfoColor ?? this.notificationInfoColor,
        notificationInActiveColor:
            notificationInActiveColor ?? this.notificationInActiveColor,
        onNotificationDangerColor:
            onNotificationDangerColor ?? this.onNotificationDangerColor,
        onNotificationSuccessColor:
            onNotificationSuccessColor ?? this.onNotificationSuccessColor,
        onNotificationErrorColor:
            onNotificationErrorColor ?? this.onNotificationErrorColor,
        onNotificationInfoColor:
            onNotificationInfoColor ?? this.onNotificationInfoColor,
        onNotificationInActiveColor:
            onNotificationInActiveColor ?? this.onNotificationInActiveColor,
        keyBoardButtonColor: keyBoardButtonColor ?? this.keyBoardButtonColor,
        onKeyBoardButtonColor:
            onKeyBoardButtonColor ?? this.onKeyBoardButtonColor,
        bottomMenuItemIconColor:
            bottomMenuItemIconColor ?? this.bottomMenuItemIconColor,
        bottomMenuItemTextColor:
            bottomMenuItemTextColor ?? this.bottomMenuItemTextColor,
        currentBottomMenuItemIconColor: currentBottomMenuItemIconColor ??
            this.currentBottomMenuItemIconColor,
        currentBottomMenuItemTextColor: currentBottomMenuItemTextColor ??
            this.currentBottomMenuItemTextColor,
        bottomMenuDividerColor:
            bottomMenuDividerColor ?? this.bottomMenuDividerColor,
        bottomMenuHeight: bottomMenuHeight ?? this.bottomMenuHeight);
  }

  @override
  SabianThemeExtension lerp(SabianThemeExtension? other, double t) {
    if (other is! SabianThemeExtension) {
      return this;
    }
    return SabianThemeExtension(
      dialogBackgroundColor:
          Color.lerp(dialogBackgroundColor, other.dialogBackgroundColor, t),
      dialogTitleColor: Color.lerp(dialogTitleColor, other.dialogTitleColor, t),
      dialogTextColor: Color.lerp(dialogTextColor, other.dialogTextColor, t),
      dialogButtonColor:
          Color.lerp(dialogButtonColor, other.dialogButtonColor, t),
      textFieldColor: Color.lerp(textFieldColor, other.textFieldColor, t),
      notificationDangerColor:
          Color.lerp(notificationDangerColor, other.notificationDangerColor, t),
      notificationSuccessColor: Color.lerp(
          notificationSuccessColor, other.notificationSuccessColor, t),
      notificationErrorColor:
          Color.lerp(notificationErrorColor, other.notificationErrorColor, t),
      notificationInfoColor:
          Color.lerp(notificationInfoColor, other.notificationInfoColor, t),
      notificationInActiveColor: Color.lerp(
          notificationInActiveColor, other.notificationInActiveColor, t),
      onNotificationSuccessColor: Color.lerp(
          onNotificationSuccessColor, other.onNotificationSuccessColor, t),
      onNotificationErrorColor: Color.lerp(
          onNotificationErrorColor, other.onNotificationErrorColor, t),
      onNotificationInfoColor:
          Color.lerp(onNotificationInfoColor, other.onNotificationInfoColor, t),
      onNotificationInActiveColor: Color.lerp(
          onNotificationInActiveColor, other.onNotificationInActiveColor, t),
      keyBoardButtonColor:
          Color.lerp(keyBoardButtonColor, other.keyBoardButtonColor, t),
      onKeyBoardButtonColor:
          Color.lerp(onKeyBoardButtonColor, other.onKeyBoardButtonColor, t),
      bottomMenuItemIconColor:
          Color.lerp(bottomMenuItemIconColor, other.bottomMenuItemIconColor, t),
      bottomMenuItemTextColor:
          Color.lerp(bottomMenuItemTextColor, other.bottomMenuItemTextColor, t),
      currentBottomMenuItemIconColor: Color.lerp(currentBottomMenuItemIconColor,
          other.currentBottomMenuItemIconColor, t),
      currentBottomMenuItemTextColor: Color.lerp(currentBottomMenuItemTextColor,
          other.currentBottomMenuItemTextColor, t),
      bottomMenuDividerColor:
          Color.lerp(bottomMenuDividerColor, other.bottomMenuDividerColor, t),
    );
  }

  static SabianThemeExtension? of(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return fromTheme(theme);
  }

  static SabianThemeExtension? fromTheme(ThemeData theme) {
    SabianThemeExtension extTheme = theme.extension();
    return extTheme;
  }
}

import 'package:flutter/material.dart';

@immutable
class SabianThemeExtension extends ThemeExtension<SabianThemeExtension> {
  final Color? dialogBackgroundColor;
  final Color? dialogTitleColor;
  final Color? dialogTextColor;
  final Color? dialogButtonColor;
  final Color? textFieldColor;

  const SabianThemeExtension(
      {this.dialogBackgroundColor,
      this.dialogTitleColor,
      this.dialogTextColor,
      this.dialogButtonColor,
      this.textFieldColor});

  @override
  SabianThemeExtension copyWith(
      {Color? dialogBackgroundColor,
      Color? dialogTitleColor,
      Color? dialogTextColor,
      Color? dialogButtonColor,
      Color? textFieldColor}) {
    return SabianThemeExtension(
        dialogBackgroundColor:
            dialogBackgroundColor ?? this.dialogBackgroundColor,
        dialogTitleColor: dialogTitleColor ?? this.dialogTitleColor,
        dialogTextColor: dialogTextColor ?? this.dialogTextColor,
        dialogButtonColor: dialogButtonColor ?? this.dialogButtonColor,
        textFieldColor: textFieldColor ?? this.textFieldColor);
  }

  @override
  SabianThemeExtension lerp(SabianThemeExtension? other, double t) {
    if (other is! SabianThemeExtension) {
      return this;
    }
    return SabianThemeExtension(
        dialogBackgroundColor:
            Color.lerp(dialogBackgroundColor, other.dialogBackgroundColor, t),
        dialogTitleColor:
            Color.lerp(dialogTitleColor, other.dialogTitleColor, t),
        dialogTextColor: Color.lerp(dialogTextColor, other.dialogTextColor, t),
        dialogButtonColor:
            Color.lerp(dialogButtonColor, other.dialogButtonColor, t),
        textFieldColor: Color.lerp(textFieldColor, other.textFieldColor, t));
  }
}

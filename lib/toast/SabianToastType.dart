import 'package:flutter/material.dart';
import 'package:sabian_tools/themes/SabianThemeExtension.dart';

typedef ColorCallBack = Function(BuildContext);

enum SabianToastType {
  error,
  danger,
  success,
  information;

  Color getBackgroundColor(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SabianThemeExtension? sabianTheme = theme.extension();
    ColorScheme scheme = theme.colorScheme;
    switch (this) {
      case SabianToastType.error:
        return sabianTheme?.notificationErrorColor ?? scheme.error;
      case SabianToastType.danger:
        return sabianTheme?.notificationDangerColor ?? scheme.error;
      case SabianToastType.success:
        return sabianTheme?.notificationSuccessColor ?? theme.primaryColor;
      case SabianToastType.information:
        return sabianTheme?.notificationInfoColor ?? theme.primaryColor;
    }
  }

  Color getTextColor(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SabianThemeExtension? sabianTheme = theme.extension();
    ColorScheme scheme = theme.colorScheme;
    switch (this) {
      case SabianToastType.error:
        return sabianTheme?.onNotificationErrorColor ?? scheme.onError;
      case SabianToastType.danger:
        return sabianTheme?.onNotificationDangerColor ?? scheme.onError;
      case SabianToastType.success:
        return sabianTheme?.onNotificationSuccessColor ?? scheme.onPrimary;
      case SabianToastType.information:
        return sabianTheme?.onNotificationInfoColor ?? scheme.onPrimary;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:sabian_tools/themes/SabianThemeExtension.dart';

class SabianColorScheme {
  SabianThemeExtension? sabianTheme;

  late ThemeData defaultTheme;

  late ColorScheme defaultScheme;

  SabianColorScheme(BuildContext context) {
    defaultTheme = Theme.of(context);
    defaultScheme = defaultTheme.colorScheme;
    sabianTheme = defaultTheme.extension();
  }
}

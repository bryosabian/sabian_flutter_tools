import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  Size get screenSize => MediaQuery.of(this).size;

  bool get isDarkMode {
    var brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }

  bool get canPageAppBarAllowClose {
    return ModalRoute.of(this)?.impliesAppBarDismissal ?? false;
  }
}

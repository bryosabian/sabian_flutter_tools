import 'package:flutter/cupertino.dart';

import 'SabianColorScheme.dart';

mixin WithSabianThemeMixIn {
  @protected
  SabianColorScheme? _colorScheme;

  @protected
  SabianColorScheme getColorScheme(BuildContext context) {
    _colorScheme ??= SabianColorScheme(context);
    return _colorScheme!;
  }
}

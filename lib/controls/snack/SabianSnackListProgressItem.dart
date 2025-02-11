import 'dart:ui';

import 'package:sabian_tools/controls/snack/SabianSnackListItem.dart';

class SabianSnackListProgressItem extends SabianSnackListItem {
  final double? progress;
  final bool isIndeterminate;
  final Color? progressColor;

  SabianSnackListProgressItem(
      {required super.id,
      super.message,
      super.type,
      super.closeable,
      super.bgColor,
      super.textColor,
      this.progress,
      this.isIndeterminate = true,
      this.progressColor,
      super.onSelect,
      super.onClose});
}

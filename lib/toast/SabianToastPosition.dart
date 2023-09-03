import 'package:flutter_styled_toast/flutter_styled_toast.dart';

enum SabianToastPosition {
  top(StyledToastPosition.top),
  center(StyledToastPosition.center),
  bottom(StyledToastPosition.bottom);

  final StyledToastPosition position;

  const SabianToastPosition(this.position);
}

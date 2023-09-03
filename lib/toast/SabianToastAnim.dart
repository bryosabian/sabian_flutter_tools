import 'package:flutter_styled_toast/flutter_styled_toast.dart';

enum SabianToastAnim {
  none(StyledToastAnimation.none),
  fade(StyledToastAnimation.fade),
  scale(StyledToastAnimation.scale);

  final StyledToastAnimation animation;

  const SabianToastAnim(this.animation);
}

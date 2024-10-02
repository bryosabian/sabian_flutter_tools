import 'package:flutter/material.dart';

Widget sabianHorizontalSpacer({double width = 2}) {
  return SizedBox(
    width: width,
  );
}

Widget sabianVerticalSpacer({double height = 2}) {
  return SizedBox(
    height: height,
  );
}

double sabianAppBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top + kToolbarHeight;
}

GestureDetector sabianSingleClick(
    {required Widget child,
    void Function()? onTap,
    bool allowChildrenClickEvents = false}) {
  return GestureDetector(
    behavior: (allowChildrenClickEvents)
        ? HitTestBehavior.translucent
        : HitTestBehavior.opaque,
    child: child,
    onTap: onTap,
  );
}

Widget sabianEmptyWidget() => Container();

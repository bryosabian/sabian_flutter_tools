import 'package:flutter/material.dart';

class SabianStretch extends StatelessWidget {
  final Axis axis;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Flex(direction: axis, children: [Expanded(child: child)]);
  }

  const SabianStretch({
    super.key,
    this.axis = Axis.vertical,
    required this.child,
  });
}

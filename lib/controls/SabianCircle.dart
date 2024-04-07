import 'package:flutter/material.dart';

class SabianCircle extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const SabianCircle({super.key,
    this.width,
    this.height,
    this.color,
    this.padding,
    required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      height: height,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: child,);
  }
}

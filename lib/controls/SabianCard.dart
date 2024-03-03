import 'package:flutter/material.dart';
import '../utils/SabianBorderRadius.dart';
import '../utils/SabianBoxShadow.dart';

class SabianCard extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;

  final SabianBorderRadius? borderRadius;
  final SabianBoxShadow? boxShadow;
  final EdgeInsets? padding;
  final double? width;
  final double? height;

  const SabianCard(
      {Key? key,
      required this.child,
      this.backgroundColor = Colors.grey,
      this.borderRadius = const SabianBorderRadius.all(2.0),
      this.boxShadow = const SabianBoxShadow(),
      this.padding = const EdgeInsets.all(0.0),
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius!.borderRadius,
          boxShadow: [boxShadow!.boxShadow]),
      child: child,
    );
  }
}

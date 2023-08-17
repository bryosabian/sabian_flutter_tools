import 'package:flutter/material.dart';

class SabianBorderRadius {
  final double? topLeft;
  final double? topRight;
  final double? bottomLeft;
  final double? bottomRight;

  const SabianBorderRadius(
      {this.topLeft, this.topRight, this.bottomLeft, this.bottomRight});

  const SabianBorderRadius.all(double value)
      : this(
            topLeft: value,
            topRight: value,
            bottomLeft: value,
            bottomRight: value);

  BorderRadiusGeometry get borderRadius => BorderRadius.only(
      topLeft: Radius.circular(topLeft!),
      topRight: Radius.circular(topRight!),
      bottomLeft: Radius.circular(bottomLeft!),
      bottomRight: Radius.circular(bottomRight!));
}

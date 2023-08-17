import 'package:flutter/material.dart';

class SabianBoxShadow {
  final Color? color;
  final double? spreadRadius;
  final double? blurRadius;
  final Offset? offset;

  const SabianBoxShadow(
      {this.color,
      this.offset = const Offset(0, 3),
      this.spreadRadius = 1,
      this.blurRadius = 7});

  BoxShadow get boxShadow => BoxShadow(
      color: color ?? Colors.grey.withOpacity(0.5),
      spreadRadius: spreadRadius!,
      blurRadius: blurRadius!,
      offset: offset!);
}

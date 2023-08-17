import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProgressPayload {
  final BuildContext context;
  final Widget parent;
  final ThemeData theme;
  final Size defaultSize;
  final AnimationController? controller;
  final Duration duration;

  const ProgressPayload({
    required this.context,
    required this.parent,
    required this.theme,
    this.defaultSize = const Size(50.0, 50.0),
    this.controller,
    this.duration = const Duration(milliseconds: 1200),
  });
}

abstract class ISabianProgressType {
  Widget create(ProgressPayload payload);
}

class CircleProgressType implements ISabianProgressType {

  const CircleProgressType();

  @override
  Widget create(ProgressPayload payload) {
    return SpinKitFadingCircle(
      color: payload.theme.progressIndicatorTheme.color,
      size: payload.defaultSize.width,
      duration: payload.duration,
      controller: payload.controller,
    );
  }
}

class RingProgressType implements ISabianProgressType {

  const RingProgressType();

  @override
  Widget create(ProgressPayload payload) {
    return SpinKitRing(
      color: payload.theme.progressIndicatorTheme.color ??
          payload.theme.primaryColor,
      size: payload.defaultSize.width,
      duration: payload.duration,
      lineWidth: 5.0,
      controller: payload.controller,
    );
  }
}

class WaveProgressType implements ISabianProgressType {

  const WaveProgressType();

  @override
  Widget create(ProgressPayload payload) {
    return SpinKitWave(
      color: payload.theme.progressIndicatorTheme.color ??
          payload.theme.primaryColor,
      size: payload.defaultSize.width,
      duration: payload.duration,
      controller: payload.controller,
    );
  }
}

class ThreeBounceProgressType implements ISabianProgressType {

  const ThreeBounceProgressType();

  @override
  Widget create(ProgressPayload payload) {
    return SpinKitThreeBounce(
      color: payload.theme.progressIndicatorTheme.color ??
          payload.theme.primaryColor,
      size: payload.defaultSize.width,
      duration: payload.duration,
      controller: payload.controller,
    );
  }
}

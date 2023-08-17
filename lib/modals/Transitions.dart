import 'dart:collection';

import 'package:flutter/material.dart';

abstract class SabianModalTransition {

  static HashMap<String, SabianModalTransition> get all {
    HashMap<String, SabianModalTransition> animations = HashMap();
    animations["fade"] = FadeModalTransition();
    animations["scale"] = ScaleModalTransition();
    animations["slide_down"] = SlideModalTransition(type: "slide_down");
    animations["slide_left"] = SlideModalTransition(type: "slide_left");
    animations["slide_right"] = SlideModalTransition(type: "slide_right");
    animations["slide_up"] = SlideModalTransition(type: "slide_up");
    return animations;
  }

  static SabianModalTransition get(String? key){
    final all = SabianModalTransition.all;
    return all[key] ?? all["fade"]!;
  }

  Widget getParent({required Animation animation, required Widget child});

  Animation createAnimation(Animation<double> controller);
}

class FadeModalTransition extends SabianModalTransition {
  @override
  Widget getParent({required Animation animation, required Widget child}) {
    return FadeTransition(
        opacity: animation as Animation<double>, child: child);
  }

  @override
  Animation createAnimation(Animation<double> controller) {
    return Tween<double>(begin: 0.0, end: 1).animate(controller);
  }
}

class ScaleModalTransition extends SabianModalTransition {
  @override
  Animation createAnimation(Animation<double> controller) {
    return CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
  }

  @override
  Widget getParent({required Animation animation, required Widget child}) {
    return ScaleTransition(scale: animation as Animation<double>, child: child);
  }
}

class SlideModalTransition extends SabianModalTransition {
  final String type;

  late HashMap<String, Offset> offsetTypes;

  late Offset current;

  SlideModalTransition({required this.type}) {
    offsetTypes = HashMap();
    offsetTypes["slide_down"] = const Offset(0, -1.0);
    offsetTypes["slide_up"] = const Offset(0, 1);
    offsetTypes["slide_left"] = const Offset(-1.0, 0);
    offsetTypes["slide_right"] = const Offset(1.0, 0);
    current = offsetTypes[type] ?? offsetTypes["slide_down"]!;
  }

  @override
  Animation createAnimation(Animation<double> controller) {
    return CurvedAnimation(parent: controller, curve: Curves.easeOut)
        .drive(Tween<Offset>(begin: current, end: Offset.zero));
  }

  @override
  Widget getParent({required Animation animation, required Widget child}) {
    return SlideTransition(
        position: animation as Animation<Offset>, child: child);
  }
}

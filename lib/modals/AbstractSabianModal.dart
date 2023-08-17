import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sabian_tools/modals/Modals.dart';
import 'package:sabian_tools/modals/Transitions.dart';

abstract class AbstractSabianModal {
  final bool? isDismissible;
  final Color? backColor;
  final bool? isDismissibleOnTouch;
  final String? key;
  bool isActive = false;

  bool get trackKey => key != null && key!.isNotEmpty;

  @protected
  StreamController<AbstractSabianModal>? _onInternalChanged;

  AbstractSabianModal({
    this.key,
    this.backColor,
    this.isDismissible,
    this.isDismissibleOnTouch,
  });

  Widget build(BuildContext context);

  void notifyChanged() {
    changeEvent.sink.add(this);
  }

  StreamController<AbstractSabianModal> get changeEvent =>
      _onInternalChanged ??= StreamController<AbstractSabianModal>();

  void _dispose() async {
    if (_onInternalChanged != null) {
      await _onInternalChanged!.close();
      _onInternalChanged = null;
    }
  }

  void close(BuildContext context) {
    _dispose();

    isActive = false;

    if (trackKey) {
      return Modals.instance().hide(context, key!);
    }
    return Modals.hideModal(context);
  }

  Future show<T>(BuildContext context, {bool isFull = true}) {
    isActive = true;

    Widget modalWidget = build(context);
    if (trackKey) {
      return Modals.instance().showAsync(context, key!, modalWidget);
    }
    if (isFull) {
      return Modals.showFullModal(context, modalWidget,
          barrierDismissible: isDismissibleOnTouch, backColor: backColor);
    }
    return Modals.showModal(context, modalWidget,
        barrierDismissible: isDismissibleOnTouch);
  }
}

abstract class AbstractSabianModalWidget extends StatefulWidget {
  final AbstractSabianModal? parent;

  final bool? isDismissible;

  final bool? isDismissibleOnTouch;

  final Color? backColor;

  final String? transition;

  final Duration? transitionDuration;

  final SabianModalTransition? customTransition;

  final ThemeData? theme;

  const AbstractSabianModalWidget(
      {Key? key,
      required this.parent,
      this.isDismissible,
      this.isDismissibleOnTouch,
      this.backColor,
      this.transition,
      this.transitionDuration,
      this.customTransition,
      this.theme})
      : super(key: key);
}

abstract class AbstractSabianModalState<T extends AbstractSabianModalWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation animation;

  late final SabianModalTransition currentTransition;

  @protected
  StreamSubscription<AbstractSabianModal>? eventSubscription;

  @override
  void initState() {
    super.initState();

    if (widget.customTransition != null) {
      currentTransition = widget.customTransition!;
    } else {
      currentTransition = SabianModalTransition.get(widget.transition);
    }
    controller = AnimationController(
        vsync: this,
        duration:
            widget.transitionDuration ?? const Duration(milliseconds: 200));

    animation = currentTransition.createAnimation(controller);

    controller.forward();

    initSubscriptions();
  }

  Future<bool> onBackPressed() async {
    final can = widget.isDismissible ?? true;
    return can;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    deInitSubscriptions();
    super.dispose();
  }

  void close(BuildContext context) {
    widget.parent?.close(context);
  }

  ThemeData getTheme(BuildContext context) {
    return widget.theme ?? Theme.of(context);
  }

  @protected
  void initSubscriptions() {
    eventSubscription ??= parentEvent?.listen((event) {
      setState(() {});
    });
  }

  @protected
  Stream<AbstractSabianModal>? get parentEvent =>
      widget.parent?.changeEvent.stream;

  @protected
  void deInitSubscriptions() {
    if (eventSubscription != null) {
      eventSubscription!.cancel();
      eventSubscription = null;
    }
  }
}

import 'package:flutter/material.dart';

mixin SabianStateAwareWidgetMixIn<T extends StatefulWidget> on State<T> {
  _StateListener? _listener;

  @override
  void initState() {
    super.initState();
    _listener = _StateListener(onStateChanged: _onStateChanged);
    WidgetsBinding.instance.addObserver(_listener!);
  }

  @override
  void dispose() {
    if (_listener != null) {
      // Remove the observer
      WidgetsBinding.instance.removeObserver(_listener!);
      _listener = null;
    }
    super.dispose();
  }

  @protected
  void onPaused() {}

  @protected
  void onResumed() {}

  @protected
  void onInactive() {}

  @protected
  void onDetached() {}

  @protected
  void onHidden() {}

  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        // widget is resumed
        break;
      case AppLifecycleState.inactive:
        onInactive();
        // widget is inactive
        break;
      case AppLifecycleState.paused:
        onPaused();
        // widget is paused
        break;
      case AppLifecycleState.detached:
        onDetached();
        // widget is detached
        break;

      case AppLifecycleState.hidden:
        onHidden();
        break;
    }
  }
}

class _StateListener with WidgetsBindingObserver {
  final void Function(AppLifecycleState) onStateChanged;

  const _StateListener({
    required this.onStateChanged,
  });

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    onStateChanged.call(state);
  }
}

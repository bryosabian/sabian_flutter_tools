import 'package:flutter/material.dart';

mixin SabianPostStateWidgetMixIn<T extends StatefulWidget> on State<T> {
  bool _hasPostInitStateCalled = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (!_hasPostInitStateCalled) {
      _hasPostInitStateCalled = true;
      onPostInitState();
    }
  }

  void onPostInitState() {}
}

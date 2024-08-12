import 'package:flutter/material.dart';

mixin SabianScrollListenerWidgetMixIn<T extends StatefulWidget> on State<T> {
  ScrollController? _scrollController;

  @protected
  ScrollController? get scrollController => _scrollController;

  bool get isScrollControllerReady =>
      scrollController != null && scrollController!.positions.isNotEmpty;

  @protected
  ScrollPosition? get currentScrollPosition =>
      (!isScrollControllerReady) ? null : scrollController!.position;

  void scrollTo(double offset) {
    if (isScrollControllerReady) {
      scrollController!.jumpTo(offset);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initScrollController();
  }

  void _initScrollController() {
    _scrollController = ScrollController();
    _scrollController!.addListener(_handleScrollController);
  }

  void _handleScrollController() {
    onScrolled(_scrollController!.position);
  }

  @protected
  void onScrolled(ScrollPosition position);

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController?.dispose();
    super.dispose();
  }
}

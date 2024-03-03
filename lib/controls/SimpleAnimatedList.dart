import 'package:flutter/material.dart';

class SimpleAnimatedList extends StatefulWidget {
  /// {@template flutter.widgets.AnimatedScrollView.itemBuilder}
  /// Called, as needed, to build children widgets.
  ///
  /// Children are only built when they're scrolled into view.
  ///
  /// The [AnimatedItemBuilder] index parameter indicates the item's
  /// position in the scroll view. The value of the index parameter will be
  /// between 0 and [initialItemCount] plus the total number of items that have
  /// been inserted with [AnimatedListState.insertItem] or
  /// [AnimatedGridState.insertItem] and less the total number of items that
  /// have been removed with [AnimatedListState.removeItem] or
  /// [AnimatedGridState.removeItem].
  ///
  /// Implementations of this callback should assume that
  /// `removeItem` removes an item immediately.
  /// {@endtemplate}
  final AnimatedItemBuilder itemBuilder;

  /// {@template flutter.widgets.AnimatedScrollView.initialItemCount}
  /// The number of items the [AnimatedList] or [AnimatedGrid] will start with.
  ///
  /// The appearance of the initial items is not animated. They
  /// are created, as needed, by [itemBuilder] with an animation parameter
  /// of [kAlwaysCompleteAnimation].
  /// {@endtemplate}
  final int initialItemCount;

  /// {@macro flutter.widgets.scroll_view.scrollDirection}
  final Axis scrollDirection;

  /// Whether the scroll view scrolls in the reading direction.
  ///
  /// For example, if the reading direction is left-to-right and
  /// [scrollDirection] is [Axis.horizontal], then the scroll view scrolls from
  /// left to right when [reverse] is false and from right to left when
  /// [reverse] is true.
  ///
  /// Similarly, if [scrollDirection] is [Axis.vertical], then the scroll view
  /// scrolls from top to bottom when [reverse] is false and from bottom to top
  /// when [reverse] is true.
  ///
  /// Defaults to false.
  final bool reverse;

  /// An object that can be used to control the position to which this scroll
  /// view is scrolled.
  ///
  /// Must be null if [primary] is true.
  ///
  /// A [ScrollController] serves several purposes. It can be used to control
  /// the initial scroll position (see [ScrollController.initialScrollOffset]).
  /// It can be used to control whether the scroll view should automatically
  /// save and restore its scroll position in the [PageStorage] (see
  /// [ScrollController.keepScrollOffset]). It can be used to read the current
  /// scroll position (see [ScrollController.offset]), or change it (see
  /// [ScrollController.animateTo]).
  final ScrollController? controller;

  /// Whether this is the primary scroll view associated with the parent
  /// [PrimaryScrollController].
  ///
  /// On iOS, this identifies the scroll view that will scroll to top in
  /// response to a tap in the status bar.
  ///
  /// Defaults to true when [scrollDirection] is [Axis.vertical] and
  /// [controller] is null.
  final bool? primary;

  /// How the scroll view should respond to user input.
  ///
  /// For example, this determines how the scroll view continues to animate after the
  /// user stops dragging the scroll view.
  ///
  /// Defaults to matching platform conventions.
  final ScrollPhysics? physics;

  /// Whether the extent of the scroll view in the [scrollDirection] should be
  /// determined by the contents being viewed.
  ///
  /// If the scroll view does not shrink wrap, then the scroll view will expand
  /// to the maximum allowed size in the [scrollDirection]. If the scroll view
  /// has unbounded constraints in the [scrollDirection], then [shrinkWrap] must
  /// be true.
  ///
  /// Shrink wrapping the content of the scroll view is significantly more
  /// expensive than expanding to the maximum allowed size because the content
  /// can expand and contract during scrolling, which means the size of the
  /// scroll view needs to be recomputed whenever the scroll position changes.
  ///
  /// Defaults to false.
  final bool shrinkWrap;

  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry? padding;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehaviour;

  ///The list controller
  final SimpleAnimatedListController listController;

  const SimpleAnimatedList(
      {super.key,
      required this.itemBuilder,
      required this.initialItemCount,
      required this.listController,
      this.scrollDirection = Axis.vertical,
      this.reverse = false,
      this.controller,
      this.primary,
      this.physics,
      this.shrinkWrap = true,
      this.padding,
      this.clipBehaviour = Clip.hardEdge});

  @override
  State<StatefulWidget> createState() {
    return _SimpleAnimatedListState();
  }
}

class _SimpleAnimatedListState extends State<SimpleAnimatedList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.listController.itemBuilder = widget.itemBuilder;
    widget.listController.listKey = _listKey;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      itemBuilder: widget.itemBuilder,
      initialItemCount: widget.initialItemCount,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      clipBehavior: widget.clipBehaviour,
    );
  }
}

class SimpleAnimatedListController {
  ///The default animation duration
  static const Duration _kDuration = Duration(milliseconds: 300);

  ///Internal call for remove call back
  @protected
  Function(int)? onRemoveCallBack;

  ///Internal call for insert call back
  @protected
  Function(int, Duration)? onInsertCallBack;

  ///Internal call for insert all callback
  @protected
  Function(int, int, Duration, bool)? onInsertAllCallBack;

  ///The item builder
  @protected
  late AnimatedItemBuilder itemBuilder;

  ///The global list key
  @protected
  late GlobalKey<AnimatedListState> listKey;

  /// Remove the item at `index` and start an animation that will be passed to
  /// `builder` when the item is visible.
  ///
  /// Items are removed immediately. After an item has been removed, its index
  /// will no longer be passed to the `itemBuilder`. However, the
  /// item will still appear for `duration` and during that time
  /// `builder` must construct its widget as needed.
  ///
  /// This method's semantics are the same as Dart's [List.remove] method: it
  /// decreases the length of items by one and shifts all items at or before
  /// `index` towards the beginning of the list of items.
  ///
  /// [builder] Signature for the builder callback used in [AnimatedListState.removeItem] and
  /// [AnimatedGridState.removeItem] to animate their children after they have been removed
  ///
  void removeItem(int index, AnimatedRemovedItemBuilder builder) {
    listKey.currentState!.removeItem(index, builder);
  }

  /// Insert an item at [index] and start an animation that will be passed
  /// to [AnimatedGrid.itemBuilder] or [AnimatedList.itemBuilder] when the item
  /// is visible.
  ///
  /// This method's semantics are the same as Dart's [List.insert] method: it
  /// increases the length of the list of items by one and shifts
  /// all items at or after [index] towards the end of the list of items.
  void insertItem(int index, {Duration duration = _kDuration}) {
    listKey.currentState!.insertItem(index, duration: duration);
  }

  /// Insert multiple items at [index] and start an animation that will be passed
  /// to [AnimatedGrid.itemBuilder] or [AnimatedList.itemBuilder] when the items
  /// are visible.
  void insertAllItems(int index, int length,
      {Duration duration = _kDuration, bool isAsync = false}) {
    listKey.currentState!
        .insertAllItems(index, length, duration: duration, isAsync: isAsync);
  }
}

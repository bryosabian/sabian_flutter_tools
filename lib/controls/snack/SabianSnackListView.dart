import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/snack/SabianSnackListController.dart';
import 'package:sabian_tools/controls/snack/SabianSnackListItem.dart';
import 'package:sabian_tools/controls/snack/SabianSnackListItemWidget.dart';
import 'package:sabian_tools/controls/snack/SabianSnackListProgressItem.dart';
import 'package:sabian_tools/controls/snack/SabianSnackProgressListItemWidget.dart';
import 'package:sabian_tools/controls/utils.dart';

class SabianSnackListView extends StatefulWidget {
  final List<SabianSnackListItem>? children;
  final SabianSnackListController? controller;
  final BorderRadius? itemRadius;
  final double? height;
  final EdgeInsets? itemPadding;

  @override
  State<StatefulWidget> createState() {
    return _SabianGroupListState();
  }

  const SabianSnackListView(
      {super.key,
      this.children,
      this.controller,
      this.itemRadius,
      this.height,
      this.itemPadding});
}

class _SabianGroupListState extends State<SabianSnackListView> {
  late List<SabianSnackListItem> _content = widget.children ?? [];

  late final SabianSnackListController _controller =
      widget.controller ?? SabianSnackListController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.init(_content, onChanged: (item) {
      setState(() {
        _content = item;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_content.isEmpty) {
      return sabianEmptyWidget();
    }
    return SizedBox(
        height: widget.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: _content
              .map((data) => Padding(
                  padding: widget.itemPadding ?? EdgeInsets.zero,
                  child: _childItem(context, data)))
              .toList(),
        ));
  }

  Widget _childItem(BuildContext context, SabianSnackListItem data) {
    if (data is SabianSnackListProgressItem) {
      return SabianSnackProgressListItemWidget(
        item: data,
        borderRadius: widget.itemRadius,
      );
    }
    return SabianSnackListItemWidget(
        item: data, borderRadius: widget.itemRadius);
  }
}

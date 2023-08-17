import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianRobotoTextField.dart';
import 'package:sabian_tools/extensions/Strings+Sabian.dart';
import 'package:sabian_tools/modals/AbstractSabianModal.dart';
import 'package:sabian_tools/modals/SabianModal.dart';
import 'package:sabian_tools/modals/callbacks.dart';
import 'package:sabian_tools/modals/list/ListModalItemWidget.dart';
import 'package:sabian_tools/themes/SabianThemeExtension.dart';
import 'package:sabian_tools/utils/tasks/SabianLinearDataSearcher.dart';
import '../Transitions.dart';
import 'ListModalItem.dart';

class SabianListModal extends SabianModal {
  @override
  final String? key;

  @override
  final String? transition;

  @override
  final String? title;

  @override
  final bool? isDismissible;

  @override
  final bool? isDismissibleOnTouch;

  final String? hint;
  final OnListModalItemSelectedCallBack? onSelected;
  final bool? hideOnSelected;
  final IconData? searchIcon;
  final bool? allowSearch;
  final List<ListModalItem> items;

  final int? differentThreadThreshold;

  SabianListModal(
      {this.key,
      this.title,
      required this.items,
      this.hint,
      this.onSelected,
      this.hideOnSelected = true,
      this.searchIcon = Icons.search,
      this.allowSearch = true,
      this.isDismissible = false,
      this.isDismissibleOnTouch = true,
      ThemeData? theme,
      this.transition = "fade",
      this.differentThreadThreshold = 50,
      Duration transitionDuration = const Duration(milliseconds: 200),
      SabianModalTransition? customTransition})
      : super(
            key: key,
            title: title,
            isDismissible: isDismissible,
            isDismissibleOnTouch: isDismissibleOnTouch,
            theme: theme,
            transition: transition,
            transitionDuration: transitionDuration,
            customTransition: customTransition);

  SabianListModal.of(this.title, this.items, this.onSelected,
      {this.key,
      this.hint,
      this.hideOnSelected = true,
      this.searchIcon = Icons.search,
      this.allowSearch = true,
      this.isDismissible = true,
      this.isDismissibleOnTouch = true,
      this.transition = 'fade',
      this.differentThreadThreshold = 50});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SabianListModalWidget(
        parent: this,
        title: title,
        items: items,
        hint: hint,
        onSelected: onSelected,
        hideOnSelected: hideOnSelected,
        searchIcon: searchIcon,
        allowSearch: allowSearch,
        isDismissible: isDismissible,
        isDismissibleOnTouch: isDismissibleOnTouch,
        theme: theme,
        transition: transition,
        transitionDuration: transitionDuration,
        customTransition: customTransition);
  }
}

class SabianListModalWidget extends SabianModalWidget {
  final String? hint;
  final OnListModalItemSelectedCallBack? onSelected;
  final bool? hideOnSelected;
  final IconData? searchIcon;
  final bool? allowSearch;
  final List<ListModalItem> items;

  const SabianListModalWidget(
      {Key? key,
      AbstractSabianModal? parent,
      String? title,
      required this.items,
      this.hint,
      this.onSelected,
      this.hideOnSelected = true,
      this.searchIcon = Icons.search,
      this.allowSearch = true,
      bool? isDismissible = false,
      bool? isDismissibleOnTouch = true,
      ThemeData? theme,
      String? transition = "fade",
      Duration? transitionDuration = const Duration(milliseconds: 200),
      SabianModalTransition? customTransition})
      : super(
            parent: parent,
            key: key,
            title: title,
            isDismissible: isDismissible,
            isDismissibleOnTouch: isDismissibleOnTouch,
            theme: theme,
            transition: transition,
            transitionDuration: transitionDuration,
            customTransition: customTransition);

  @override
  State<StatefulWidget> createState() {
    return _SabianListModal();
  }
}

class _SabianListModal extends SabianModalWidgetState<SabianListModalWidget> {
  late List<ListModalItem> _items;
  late List<ListModalItem> _allItems;

  late final SabianLinearDataSearcher<ListModalItem> _searcher;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _allItems = widget.items.toList(growable: true);
    int differentThreadThreshold = 50;
    if (widget.parent != null && widget.parent is SabianListModal) {
      differentThreadThreshold =
          (widget.parent as SabianListModal).differentThreadThreshold ??
              differentThreadThreshold;
    }
    _searcher = SabianLinearDataSearcher(
        onSearched: _onSearched,
        searchCriteria: (item) => [item.title],
        differentThreadThreshold: differentThreadThreshold);
    _items = widget.items;
  }

  @override
  void dispose() {
    super.dispose();
    _searcher.dispose();
  }

  @override
  Widget getDefaultChild(BuildContext context, ThemeData theme) {
    final canSearch = widget.allowSearch ?? true;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, //Make it wrap
        children: [
          getDefaultHeader(context, theme),
          getDivider(theme),
          if (canSearch) _getSearch(context, theme),
          if (canSearch) getDivider(theme),
          _getList(context, theme)
        ]);
  }

  Widget _getList(BuildContext context, ThemeData theme) {
    BorderRadius radius = getRadius();
    return Flexible(
        fit: FlexFit.loose,
        child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: radius.bottomRight, bottomRight: radius.bottomLeft),
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: _items.length,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int position) =>
                  _getChild(context, position),
              separatorBuilder: (context, position) => getDivider(theme),
            )));
  }

  Widget _getSearch(BuildContext context, ThemeData theme) {
    ColorScheme colorScheme = theme.colorScheme;
    SabianThemeExtension? sabianTheme = theme.extension<SabianThemeExtension>();

    final canShowIcon = widget.searchIcon != null;

    final pad = (canShowIcon)
        ? EdgeInsets.only(
            left: 0,
            top: 2,
            right: SabianModalWidgetState.PADDING.right,
            bottom: 2)
        : SabianModalWidgetState.PADDING;

    Color textColor = sabianTheme?.dialogTextColor ??
        (sabianTheme?.textFieldColor ?? colorScheme.onSurface);

    Color hintColor = theme.hintColor;
    BorderRadius radius = getRadius();

    final prefixIcon = (canShowIcon) ? Icon(widget.searchIcon!) : null;

    return Flexible(
        fit: FlexFit.loose,
        child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: radius.bottomLeft, bottomRight: radius.bottomRight),
            child: Padding(
                padding: pad,
                child: SabianRobotoTextField(
                  robotoType: "Regular",
                  hint: widget.hint ?? "Search %s".format([widget.title ?? ""]),
                  hintColor: hintColor,
                  contentPadding: EdgeInsets.zero,
                  backgroundColor: sabianTheme?.dialogBackgroundColor ??
                      theme.dialogBackgroundColor,
                  prefixIcon: prefixIcon,
                  iconColor: theme.hintColor,
                  textColor: textColor,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  onChanged: _onSearch,
                ))));
  }

  Widget _getChild(BuildContext context, int position) {
    ListModalItem item = _items[position];
    return GestureDetector(
        //Handle the tap and don't pass to children
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _select(context, item, position);
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                  padding: SabianModalWidgetState.PADDING,
                  child: ListModalItemWidget(item))
            ]));
  }

  void _select(BuildContext context, ListModalItem item, int position) {
    widget.onSelected?.call(item, position, widget);
    if (widget.hideOnSelected ?? true) {
      close(context);
    }
  }

  void _onSearched(List<ListModalItem> newItems) {
    setState(() {
      _items = newItems;
    });
  }

  void _onSearch(String? value) {
    final query = value ?? "";
    _searcher.search(_allItems, query);
  }
}

import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';

class SabianRadioButton<T> extends StatefulWidget {
  final String? title;
  final Widget? titleWidget;
  final T? value;
  final T? selectedValue;
  final Function(T?)? onChanged;
  final bool autoSelectOnChanged;
  final bool unSelectOnReSelect;
  final Color? textColor;
  final double? textSize;
  final MaterialStateColor? fillColor;
  final Color? activeColor;
  final Color? hoverColor;
  final Color? focusColor;
  final bool? leading;
  final bool? trailing;
  final double? horizontalTitleGap;
  final EdgeInsets? contentPadding;

  const SabianRadioButton(
      {super.key,
      this.title,
      this.titleWidget,
      this.value,
      this.selectedValue,
      this.onChanged,
      this.autoSelectOnChanged = true,
      this.unSelectOnReSelect = true,
      this.textColor,
      this.textSize,
      this.fillColor,
      this.activeColor,
      this.hoverColor,
      this.focusColor,
      this.leading = true,
      this.trailing = false,
      this.horizontalTitleGap = 2,
      this.contentPadding = EdgeInsets.zero});

  @override
  State<StatefulWidget> createState() {
    return _SabianRadioButton<T>();
  }
}

class _SabianRadioButton<T> extends State<SabianRadioButton> {
  T? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    final radio = Radio<T>(
      fillColor: widget.fillColor,
      activeColor: widget.activeColor,
      focusColor: widget.focusColor,
      hoverColor: widget.hoverColor,
      value: widget.value,
      groupValue: _selected,
      onChanged: null,
    );
    return GestureDetector(
        child: ListTile(
            horizontalTitleGap: widget.horizontalTitleGap,
            contentPadding: widget.contentPadding,
            tileColor: null,
            selectedTileColor: null,
            selectedColor: null,
            textColor: widget.textColor,
            title: widget.titleWidget ??
                SabianRobotoText(
                  widget.title ?? "",
                  textColor: widget.textColor,
                  fontSize: widget.textSize,
                ),
            leading: (widget.leading == true) ? radio : null,
            trailing: (widget.trailing == true) ? radio : null,
            onTap: () {
              if (_selected != widget.value) {
                _onChanged(widget.value);
              } else if (widget.unSelectOnReSelect) {
                _onChanged(null);
              }
            }));
  }

  void _onChanged(T? value) {
    if (widget.autoSelectOnChanged == true) {
      setState(() {
        _selected = value;
      });
    } else {
      _selected = value;
    }
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }
}

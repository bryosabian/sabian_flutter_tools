import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';
import 'package:sabian_tools/controls/SabianWrappedRobotoText.dart';
import 'package:sabian_tools/controls/utils.dart';
import 'package:sabian_tools/modals/list/ListModalItem.dart';

class SabianFullErrorWidget extends StatelessWidget {
  final bool show;
  final Widget child;
  final String? text;
  final String? title;
  final IconData? icon;
  final ListIconType iconType;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final Color? titleColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? buttonColor;
  final double? space;
  final int? maxErrorLines;

  bool get _hasButton => buttonText != null || onButtonPressed != null;

  const SabianFullErrorWidget(
      {super.key,
      this.show = true,
      required this.child,
      this.text,
      this.title,
      this.icon,
      this.iconType = ListIconType.system,
      this.buttonText,
      this.onButtonPressed,
      this.titleColor,
      this.textColor,
      this.iconColor,
      this.buttonColor,
      this.space = 2,
      this.maxErrorLines = 12});

  @override
  Widget build(BuildContext context) {
    if (show == false) {
      return child;
    }
    return _error(context);
  }

  Widget _error(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) _icon(context),
            if (icon != null) sabianVerticalSpacer(height: space ?? 2),
            _title(context),
            sabianVerticalSpacer(height: space ?? 2),
            _text(context),
            if (_hasButton) sabianVerticalSpacer(height: space ?? 2),
            if (_hasButton) _button(context)
          ],
        ));
  }

  Widget _icon(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Icon(icon, size: 50, color: scheme.onSurface);
  }

  Widget _title(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
        child: SabianWrappedRobotoText(
      title ?? "Error",
      isParentFlexible: false,
      textColor: titleColor ?? scheme.onSurface,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      align: TextAlign.center,
      maxLines: 3,
    ));
  }

  Widget _text(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
        child: SabianWrappedRobotoText(
      isParentFlexible: false,
      text ?? "An error occurred",
      textColor: textColor ?? scheme.onSurface,
      fontSize: 16,
      align: TextAlign.center,
      maxLines: maxErrorLines,
      overflow: TextOverflow.ellipsis,
    ));
  }

  Widget _button(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
        child: GestureDetector(
            onTap: onButtonPressed,
            child: SabianRobotoText(
              buttonText ?? "Retry",
              fontWeight: FontWeight.bold,
              textColor: buttonColor ?? scheme.onSurface,
              fontSize: 16,
            )));
  }
}

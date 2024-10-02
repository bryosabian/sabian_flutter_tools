import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sabian_tools/controls/SabianWrappedRobotoText.dart';
import 'package:sabian_tools/controls/utils.dart';

class SabianFullLoaderWidget extends StatelessWidget {
  final bool show;
  final String? loaderText;
  final bool? showIndicator;
  final Color? indicatorColor;
  final Color? loaderTextColor;
  final Color? bgColor;
  final Widget child;

  const SabianFullLoaderWidget({
    super.key,
    this.show = true,
    required this.child,
    this.loaderText,
    this.showIndicator,
    this.indicatorColor,
    this.loaderTextColor,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    if (show == false) {
      return child;
    }
    return _loader(context);
  }

  Widget _loader(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bgColor = this.bgColor ?? scheme.surface.withOpacity(0.6);
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: bgColor,
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (showIndicator == true) _indicator(context),
            if (showIndicator == true) sabianHorizontalSpacer(width: 1),
            _text(context)
          ],
        ),
      ),
    );
  }

  Widget _indicator(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SpinKitFadingCircle(
        color: indicatorColor ?? scheme.primary, size: 25);
  }

  Widget _text(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SabianWrappedRobotoText(loaderText ?? "Loading...",
        textColor: loaderTextColor ?? scheme.onSurface, fontSize: 14);
  }
}

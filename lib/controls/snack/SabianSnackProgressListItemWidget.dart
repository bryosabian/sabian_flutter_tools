import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/snack/SabianSnackListProgressItem.dart';

import '../SabianIcon.dart';
import '../SabianWrappedRobotoText.dart';
import '../utils.dart';

class SabianSnackProgressListItemWidget extends StatelessWidget {
  final SabianSnackListProgressItem item;
  final BorderRadius? borderRadius;

  const SabianSnackProgressListItemWidget(
      {super.key, required this.item, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final bgColor = item.finalBgColor(context);
    final textColor = item.finalTextColor(context);
    return sabianSingleClick(
        allowChildrenClickEvents: true,
        onTap: () => item.onSelect?.call(item),
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration:
                BoxDecoration(color: bgColor, borderRadius: borderRadius),
            child: Stack(children: [
              if (item.closeable == true && item.onClose != null)
                Align(
                  alignment: Alignment.topRight,
                  child: sabianSingleClick(
                      onTap: () => item.onClose!.call(item),
                      child: SabianIcon(
                        Icons.cancel,
                        size: 20,
                        color: textColor,
                      )),
                ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SabianWrappedRobotoText(
                    item.message ?? "",
                    isParentFlexible: false,
                    textColor: textColor,
                    fontSize: 14,
                  ),
                  sabianVerticalSpacer(height: 2),
                  LinearProgressIndicator(
                    value:
                        (item.isIndeterminate == true) ? null : item.progress,
                    color: textColor,
                    backgroundColor: bgColor?.withOpacity(0.4),
                  )
                ],
              ),
            ])));
  }
}

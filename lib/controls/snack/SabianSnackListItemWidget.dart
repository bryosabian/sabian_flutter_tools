import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianIcon.dart';
import 'package:sabian_tools/controls/SabianWrappedRobotoText.dart';
import 'package:sabian_tools/controls/snack/SabianSnackListItem.dart';
import 'package:sabian_tools/controls/utils.dart';

class SabianSnackListItemWidget extends StatelessWidget {
  final SabianSnackListItem item;
  final BorderRadius? borderRadius;

  const SabianSnackListItemWidget(
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
          decoration: BoxDecoration(color: bgColor, borderRadius: borderRadius),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: SabianWrappedRobotoText(
                item.message ?? "",
                isParentFlexible: false,
                textColor: textColor,
                fontSize: 14,
              )),

              ///Action
              if (item.action != null)
                sabianSingleClick(
                    onTap: () => item.action!.value.call(item),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: SabianWrappedRobotoText(
                          item.action!.key,
                          isParentFlexible: false,
                          textColor: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ))),

              ///Close action
              if (item.closeable == true && item.onClose != null)
                sabianSingleClick(
                    onTap: () => item.onClose!.call(item),
                    child: SabianIcon(
                      Icons.cancel,
                      size: 20,
                      color: textColor,
                    ))
            ],
          ),
        ));
  }
}

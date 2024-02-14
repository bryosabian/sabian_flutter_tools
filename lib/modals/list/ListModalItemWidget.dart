import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabian_tools/controls/SabianImage.dart';
import 'package:sabian_tools/controls/SabianRobotoText.dart';
import 'package:sabian_tools/controls/SabianWrappedRobotoText.dart';
import 'package:sabian_tools/modals/list/ListModalItem.dart';
import 'package:sabian_tools/modals/progress/ISabianProgressType.dart';
import 'package:sabian_tools/themes/SabianThemeExtension.dart';

class ListModalItemWidget extends StatefulWidget {
  final ListModalItem item;

  const ListModalItemWidget(this.item, {Key? key}) : super(key: key);

  @override
  State createState() {
    return _ListModalItemWidget();
  }
}

class _ListModalItemWidget extends State<ListModalItemWidget> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    SabianThemeExtension? sabianTheme = theme.extension();

    ListModalItem item = widget.item;

    final iconSize = item.iconSize ?? const Size(20, 20);

    List<Widget> mainBody = [];

    if (item.hasAnyIcon) {
      if (item.hasImageIcon) {
        mainBody.add(_getImageIcon(context, iconSize));
      } else {
        mainBody.add(_getIcon(context, iconSize.width));
      }
    }

    Widget text = SabianWrappedRobotoText(
      item.title,
      textColor: sabianTheme?.dialogTextColor ?? theme.colorScheme.onSurface,
      fontSize: 14,
      fontWeight: FontWeight.normal,
      type: "Regular",
      softwrap: true,
    );

    if (mainBody.isNotEmpty) {
      //Add padding between icon and text
      //Padding/Container parent is not good for flexible text layouts even when wrapped in rows
      mainBody.add(const SizedBox(width: 5, height: 0));
    }

    mainBody.add(text);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: mainBody,
    );
  }

  Widget _getImageIcon(BuildContext context, Size size) {
    ThemeData theme = Theme.of(context);
    Color iconErrorColor = theme.colorScheme.error;
    ListModalItem item = widget.item;
    Widget imageView;
    BoxFit fit = BoxFit.cover;
    if (item.imageIconType == ListImageIconType.url) {
      imageView = SabianImage(
          url: item.image!,
          fit: fit,
          placeholder: (context, url) => const RingProgressType().create(
                ProgressPayload(
                    context: context, parent: widget, theme: Theme.of(context)),
              ),
          errorWidget: (context, url, error) =>
              Icon(Icons.error, size: size.width, color: iconErrorColor));
    } else {
      imageView = SabianImage(assetImage: AssetImage(item.image!), fit: fit);
    }

    Widget imageContainer;
    if (item.circleImageIcons) {
      imageContainer = CircleAvatar(child: imageView, radius: size.width);
    } else {
      imageContainer = ClipRRect(
          borderRadius: BorderRadius.circular(10.0), child: imageView);
    }
    return SizedBox(
        width: size.width, height: size.height, child: imageContainer);
  }

  Widget _getIcon(BuildContext context, double fontSize) {
    ListModalItem item = widget.item;
    ThemeData theme = Theme.of(context);
    SabianThemeExtension? sabianTheme = theme.extension();
    Color iconColor =
        sabianTheme?.dialogTextColor ?? theme.colorScheme.onSurface;
    return item.iconType.toIcon(item.icon!, iconColor, fontSize);
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sabian_tools/controls/SabianIcon.dart';
import 'package:sabian_tools/modals/list/ListModalItem.dart';

import 'SabianImage.dart';

class SabianCircleImage extends StatelessWidget {
  final Color? borderColor;
  final double radius;
  final double? borderWidth;

  final IconData? defaultIcon;
  final ListIconType? defaultIconType;
  final Color? defaultIconBackground;
  final Color? defaultIconOnBackground;

  final String? imageUrl;
  final ImageProvider? localImage;
  final BoxFit? fit;

  const SabianCircleImage({super.key,
    this.borderColor,
    required this.radius,
    this.borderWidth,
    this.defaultIcon,
    this.defaultIconType,
    this.defaultIconBackground,
    this.defaultIconOnBackground,
    this.imageUrl,
    this.localImage,
    this.fit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primary = defaultIconBackground ?? colorScheme.primary;
    final onPrimary = defaultIconOnBackground ?? colorScheme.onPrimary;

    final defaultAvatar = SizedBox(
        width: radius,
        height: radius,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primary,
          child: SabianIcon(defaultIcon ?? Icons.photo,
              size: radius / 1.6,
              iconType: defaultIconType ?? ListIconType.system,
              color: onPrimary),
        ));

    final image = CachedNetworkImage(
        fit: fit,
        width: radius,
        height: radius,
        imageUrl: imageUrl ?? "https://noimage.com",
        imageBuilder: (context, imageProvider) =>
            CircleAvatar(
                radius: radius,
                backgroundImage: imageProvider,
                backgroundColor: Colors.grey[200]),
        placeholder: (context, url) => defaultAvatar,
        errorWidget: (context, url, error) => defaultAvatar);

    if (borderColor == null && borderWidth == null) {
      return image;
    }
    return Container(
      child: image,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
              width: borderWidth ?? 1,
              color: borderColor ?? theme.dividerColor)),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SabianImage extends StatefulWidget {
  final String? url;
  final AssetImage? assetImage;
  final BoxFit? fit;

  /// Widget displayed while the target [imageUrl] is loading.
  final PlaceholderWidgetBuilder? placeholder;

  /// Widget displayed while the target [imageUrl] is loading.
  final ProgressIndicatorBuilder? progressIndicatorBuilder;

  /// Widget displayed while the target [imageUrl] failed loading.
  final LoadingErrorWidgetBuilder? errorWidget;

  const SabianImage({this.url,
    this.assetImage,
    this.fit,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.errorWidget});

  @override
  State<StatefulWidget> createState() {
    return _SabianImage();
  }
}

class _SabianImage extends State<SabianImage> {
  @override
  Widget build(BuildContext context) {
    if (widget.url != null) {
      return _getUrlImage();
    }
    return _getLocalImage();
  }

  Widget _getUrlImage() {
    return CachedNetworkImage(
      imageUrl: widget.url!,
      fit: widget.fit,
      progressIndicatorBuilder: widget.progressIndicatorBuilder,
      errorWidget: widget.errorWidget,
      placeholder: widget.placeholder,
    );
  }

  Widget _getLocalImage() {
    return Image(image: widget.assetImage!, fit: widget.fit);
  }
}

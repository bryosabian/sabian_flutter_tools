import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

typedef SabianImageLoaderWidgetBuilder = Widget Function(
    BuildContext context, DownloadProgress? progress);

typedef SabianImageErrorWidgetBuilder = Widget Function(
    BuildContext context, Object error, StackTrace? stackTrace);

typedef SabianPlaceholderWidgetBuilder = Widget Function(BuildContext context);

class SabianImage extends StatefulWidget {
  final String? url;
  final ImageProvider? localImage;
  final BoxFit? fit;

  /// Widget displayed while the target [imageUrl] is loading.
  final SabianPlaceholderWidgetBuilder? placeholderWidget;

  /// Widget displayed while the target [imageUrl] is loading.
  final SabianImageLoaderWidgetBuilder? progressWidget;

  /// Widget displayed while the target [imageUrl] failed loading.
  final SabianImageErrorWidgetBuilder? errorWidget;

  ///The default loader widget size
  final double defaultLoaderSize;

  ///The default error widget size
  final double defaultPlaceholderSize;

  const SabianImage(
      {super.key,
      this.url,
      this.localImage,
      this.fit,
      this.placeholderWidget,
      this.progressWidget,
      this.errorWidget,
      this.defaultPlaceholderSize = 40,
      this.defaultLoaderSize = 50});

  @override
  State<StatefulWidget> createState() {
    return _SabianImage();
  }
}

class _SabianImage extends State<SabianImage> {
  @override
  Widget build(BuildContext context) {
    if (widget.url != null) {
      return _getUrlImage(context);
    }
    return _getLocalImage(context);
  }

  Widget _getUrlImage(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: widget.url!,
        fit: widget.fit,
        progressIndicatorBuilder: (c, w, p) {
          if (widget.progressWidget != null) {
            return widget.progressWidget!.call(c, p);
          }
          return _defaultProgress(context);
        },
        errorWidget: (c, _, e) {
          if (widget.errorWidget != null) {
            return widget.errorWidget!.call(c, e, null);
          }
          if (widget.placeholderWidget != null) {
            return widget.placeholderWidget!.call(c);
          }
          return _defaultPlaceholder(context);
        },
        placeholder: (c, _) {
          if (widget.placeholderWidget != null) {
            return widget.placeholderWidget!.call(c);
          }
          return _defaultPlaceholder(context);
        });
  }

  Widget _getLocalImage(BuildContext context) {
    return Image(
      image: widget.localImage!,
      fit: widget.fit,
      loadingBuilder: (c, w, i) {
        if (i == null) {
          return w;
        }
        return _defaultProgress(context);
      },
      errorBuilder: (c, o, s) {
        if (widget.errorWidget != null) {
          return widget.errorWidget!.call(c, o, s);
        }
        if (widget.placeholderWidget != null) {
          return widget.placeholderWidget!.call(c);
        }
        return _defaultPlaceholder(context);
      },
    );
  }

  Widget _defaultProgress(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme scheme = theme.colorScheme;
    return SizedBox(
        width: widget.defaultLoaderSize,
        height: widget.defaultLoaderSize,
        child: CircularProgressIndicator(
          backgroundColor: scheme.surface,
          color: scheme.primary,
          strokeWidth: 2,
          value: null,
        ));
  }

  Widget _defaultPlaceholder(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme scheme = theme.colorScheme;
    return Center(
        child: Icon(
      Icons.image,
      size: 50,
      color: scheme.onBackground,
    ));
  }
}

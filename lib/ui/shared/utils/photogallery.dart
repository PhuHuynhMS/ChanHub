import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../themes/chanhub_colors.dart';

void showPhotoViewGallery(
    BuildContext context, List<ImageProvider> images, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Stack(
        children: <Widget>[
          // PhotoView Gallery
          PhotoViewGallery.builder(
            itemCount: images.length,
            builder: (BuildContext context, int index) =>
                PhotoViewGalleryPageOptions(imageProvider: images[index]),
            scrollPhysics: const BouncingScrollPhysics(),
            pageController: PageController(initialPage: index),
            backgroundDecoration: const BoxDecoration(
              color: ChanHubColors.onSurface,
            ),
          ),

          // Close Button
          Positioned(
            top: 5.0,
            right: 5.0,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
              color: ChanHubColors.surface,
            ),
          ),
        ],
      );
    },
  );
}

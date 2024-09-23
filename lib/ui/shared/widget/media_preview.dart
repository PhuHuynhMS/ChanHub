import 'package:flutter/material.dart';

import '../../shared/utils/photogallery.dart';

class MediaPreview extends StatelessWidget {
  const MediaPreview(
    this.mediaUrls, {
    super.key,
    this.height = 200.0,
    this.width,
  });

  final List<String> mediaUrls;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: mediaUrls.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () => showPhotoViewGallery(
            context,
            mediaUrls.map((url) => NetworkImage(url)).toList(),
            index,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              mediaUrls[index],
              fit: BoxFit.cover,
              width: width,
            ),
          ),
        ),
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 10.0),
      ),
    );
  }
}

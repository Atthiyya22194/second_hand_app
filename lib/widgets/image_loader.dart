import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader(
      {super.key, this.imageUrl, required this.height, required this.width});

  final double height;
  final String? imageUrl;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <CachedNetworkImage>[
        CachedNetworkImage(
          imageUrl: imageUrl ?? "https://www.tibs.org.tw/images/default.jpg",
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              const Center(child: Text('Loading image...')),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.fitHeight,
          height: height,
          width: width,
        )
      ],
    );
  }
}

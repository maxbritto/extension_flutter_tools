import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkOrFileImage extends StatelessWidget {
  final String imageUri;
  final BoxFit? fit;
  final double? width;
  final double? height;
  const NetworkOrFileImage(
      {required this.imageUri, this.height, this.width, this.fit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUri.startsWith("file://")) {
      final uri = Uri.tryParse(imageUri);
      if (uri == null) {
        return const SizedBox();
      }
      final file = File(uri.toFilePath());
      return Image.file(file, fit: fit, width: width, height: height);
    } else if (imageUri.startsWith("assets/")) {
      return Image.asset(imageUri, fit: fit, width: width, height: height);
    } else {
      return CachedNetworkImage(
          imageUrl: imageUri, fit: fit, width: width, height: height);
    }
  }
}

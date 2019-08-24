import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ATSourceLogoImage extends StatelessWidget {
  ATSourceLogoImage({
    this.width = 50.0,
    this.height = 50.0,
    @required this.url
  });

  final double width;
  final double height;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ATNetworkImage extends StatelessWidget {
  ATNetworkImage({@required this.imageUrl, this.width = 200, this.height = 100});

  final String imageUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.contain,
      placeholder: (context, url) => _buildNetworkImagePlaceholder(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  Widget _buildNetworkImagePlaceholder() {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: Color.fromRGBO(64, 64, 64, 0.5),
        highlightColor: Color.fromRGBO(166, 166, 166, 1.0),
        child: Container(
          width: 200.0,
          height: 100.0,
          color: Color.fromRGBO(217, 217, 217, 0.5),
        )
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ATNetworkImage extends StatelessWidget {
  ATNetworkImage({this.imageUrl});

  final String imageUrl;

  Widget _buildNetworkImagePlaceholder() {
    return SizedBox(
      width: 200.0,
      height: 100.0,
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

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => _buildNetworkImagePlaceholder(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewShoe extends StatelessWidget {
  const NewShoe({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                blurRadius: 0.8,
                color: Colors.white,
                spreadRadius: 1,
                offset: Offset(0, 1))
          ]),
      height: MediaQuery.sizeOf(context).height *
          0.15,
      width:
      MediaQuery.sizeOf(context).width * 0.28,
      child: CachedNetworkImage(imageUrl: url),
    );
  }
}

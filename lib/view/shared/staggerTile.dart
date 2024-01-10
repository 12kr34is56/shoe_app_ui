import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoeapp/view/shared/appStyle.dart';

class StaggeredTile extends StatefulWidget {
  const StaggeredTile(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.price});
  final String imageUrl;
  final String name;
  final String price;
  @override
  State<StaggeredTile> createState() => _StaggeredTileState();
}

class _StaggeredTileState extends State<StaggeredTile> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(imageUrl: widget.imageUrl,fit: BoxFit.fill,),
              SizedBox(
                height: 75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.name,style: AppStyleWithht(20, Colors.black, FontWeight.w700,1),),
                    Text(widget.price,style: AppStyleWithht(20, Colors.black, FontWeight.w500,1),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

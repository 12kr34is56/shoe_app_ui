import 'package:flutter/material.dart';

import '../../models/sneakerModel.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart' as grid ;

import 'package:shoeapp/view/shared/staggerTile.dart';
class LatestNews extends StatelessWidget {
  const LatestNews({
    super.key,
    required Future<List<SneakersModel>> male,
    required this.height,
  }) : _male = male;

  final Future<List<SneakersModel>> _male;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SneakersModel>>(
        future: _male,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          } else {
            final male = snapshot.data;
            return grid.StaggeredGridView.countBuilder(
                padding: EdgeInsets.zero,
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 16,
                itemCount: male!.length,
                scrollDirection: Axis.vertical,
                staggeredTileBuilder: (index) =>
                    grid.StaggeredTile.extent((index % 2 == 0)?1:1, (index %4 == 1 || index % 4 == 3)?
                    height*0.35:height*0.3),
                itemBuilder: (context, index) {
                  final shoe = snapshot.data![index];
                  return StaggeredTile(imageUrl: shoe.imageUrl[1], name: shoe.name, price: '\$${shoe.price}');
                });
          }
        });
  }
}

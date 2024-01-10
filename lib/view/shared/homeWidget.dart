import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoeapp/controller/productProvider.dart';
import 'package:shoeapp/models/sneakerModel.dart';
import 'package:shoeapp/view/shared/appStyle.dart';
import 'package:shoeapp/view/shared/newShoe.dart';
import 'package:shoeapp/view/shared/productCard.dart';
import 'package:shoeapp/view/ui/productByCart.dart';
import 'package:shoeapp/view/ui/productPage.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<SneakersModel>> male,
    required this.tabIndex,
  }) : _male = male;

  final Future<List<SneakersModel>> _male;
  final int tabIndex;
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.40,
          child: FutureBuilder<List<SneakersModel>>(
              future: _male,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                } else {
                  final male = snapshot.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final shoe = snapshot.data![index];
                        return InkWell(
                          onTap: () {
                            productProvider.shoeSize = shoe.sizes;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
                                        id: shoe.id, category: shoe.category)));
                          },
                          child: ProductScreen(
                              price: '\$${shoe.price}',
                              category: shoe.category,
                              id: shoe.id,
                              name: shoe.name,
                              image: shoe.imageUrl[0]),
                        );
                      });
                }
              }),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 15),
              child: Row(
                children: [
                  Text(
                    "Latest Shoes",
                    style: AppStyle(24, Colors.black, FontWeight.bold),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductByCart(
                                    tabIndex: tabIndex,
                                  )));
                    },
                    child: Row(
                      children: [
                        Text(
                          "Show All",
                          style: AppStyle(22, Colors.black, FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 40,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.12,
          child: FutureBuilder<List<SneakersModel>>(
              future: _male,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                } else {
                  final male = snapshot.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              NewShoe(url: snapshot.data![index].imageUrl[1]),
                        );
                      });
                }
              }),
        )
      ],
    );
  }
}

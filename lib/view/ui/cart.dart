import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shoeapp/controller/cartProvider.dart';
import 'package:shoeapp/view/shared/appStyle.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shoeapp/view/shared/checkOutButton.dart';
import 'package:shoeapp/view/ui/homePage.dart';
import 'package:shoeapp/view/ui/mainScreen.dart';

import '../../controller/productProvider.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final _cartBox = Hive.box('cart_box');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getAllCartData();

    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 30,
                  ),
                ),
                Text(
                  "My Cart",
                  style: AppStyle(36, Colors.black, FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: height * 0.62,
                  width: width,
                  child: ListView.builder(
                      itemCount: cartProvider.cart.length,
                      itemBuilder: (context, index) {
                        final data = cartProvider.cart[index];
                        return Padding(
                          padding: EdgeInsets.all(8),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  height: height * 0.13,
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 1),
                                            color: Colors.grey.shade500,
                                            blurRadius: 0.3,
                                            spreadRadius: 5),
                                      ]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            children:[ Padding(
                                              padding: EdgeInsets.all(12),
                                              child: CachedNetworkImage(
                                                imageUrl: data['imageUrl'],
                                                height: 70,
                                                width: 70,
                                                fit: BoxFit.fill,
                                              ),
                                            ),Positioned(
                                              bottom: -2,
                                              child: InkWell(
                                                  onTap: (){
                                                    cartProvider.delete(data['keys']);
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
                                                  },
                                                  child: Container(
                                                      height: 40,
                                                      width: 30,
                                                      decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.only(topRight: Radius.circular(12))),
                                                      child: Icon(CupertinoIcons.delete,color: Colors.white,size: 20,))),
                                            ),]
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 12, left: 1),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data['name'],
                                                  style: AppStyle(
                                                      16,
                                                      Colors.black,
                                                      FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  data['category'],
                                                  style: AppStyle(
                                                      14,
                                                      Colors.grey,
                                                      FontWeight.w600),
                                                ),
                                                // SizedBox(
                                                //   height: 2,
                                                // ),
                                                Row(children: [
                                                  Text(
                                                    data['price'],
                                                    style: AppStyle(
                                                        16,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),

                                                ]),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(16)),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      cartProvider.increament(data['qty']);
                                                    },
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.black,
                                                            borderRadius: BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        16),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        16))),
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .plus,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                  Text(
                                                    data['qty'].toString(),
                                                    style: AppStyle(
                                                        16,
                                                        Colors.black,
                                                        FontWeight.w500),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      cartProvider.decreament(data['qty']);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                          Colors.grey,
                                                          borderRadius: BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                  16),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                  16))),
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .minus,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CheckOutButton(width: width, name: "Procced to Check out", onTap: (){})
                  ),
                )
              ],
            ),
          ],
        ),
      ),

    );
  }
}

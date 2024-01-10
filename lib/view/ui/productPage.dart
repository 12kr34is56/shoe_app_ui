import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shoeapp/controller/favoriteProvider.dart';
import 'package:shoeapp/controller/productProvider.dart';
import 'package:shoeapp/view/shared/appStyle.dart';
import 'package:shoeapp/view/shared/checkOutButton.dart';
import 'package:shoeapp/view/ui/favorite.dart';
import '../../controller/cartProvider.dart';
import '../../models/sneakerModel.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});
  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {


  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    productProvider.getShoes(widget.category, widget.id);
    final PageController pageController = PageController();
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    // final favoriteProvider = Provider.of<FavoriteProvider>(context,listen: true);
    return Scaffold(
      body: FutureBuilder<SneakersModel>(
        future: productProvider.sneakers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          } else {
            final sneaker = snapshot.data;
            return Consumer<ProductProvider>(
              builder: (context, value, child) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                value.shoeSize.clear();
                              },
                              child: const Icon(Icons.close),
                            ),
                            GestureDetector(
                              child: const Icon(FontAwesomeIcons.ellipsis),
                            ),
                          ],
                        ),
                      ),
                      pinned: false,
                      //todo try to change them
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: height * 0.5,
                              width: width,
                              child: PageView.builder(
                                  itemCount: sneaker!.imageUrl.length,
                                  scrollDirection: Axis.horizontal,
                                  controller: pageController,
                                  onPageChanged: (page) {
                                    value.setPage(page);
                                  },
                                  itemBuilder: (context, int index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          height: height * 0.35,
                                          width: width,
                                          color: Colors.grey.shade300,
                                          child: CachedNetworkImage(
                                            imageUrl: sneaker.imageUrl[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                            top: height * 0.1,
                                            right: 15,
                                            child: Consumer<FavoriteProvider>(
                                              builder: ( context,  value,  child) {
                                                return InkWell(
                                                  onTap: () {
                                                    if (value.ids.contains(widget.id)) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const favoritePage()));
                                                    } else {
                                                      value.createFav(
                                                          {
                                                            "id": sneaker.id,
                                                            "name" : sneaker.name,
                                                            "category" : sneaker.category,
                                                            "price" : sneaker.price,
                                                            "imageUrl" : sneaker.imageUrl[0],

                                                          });
                                                      // setState(() {
                                                      //
                                                      // });
                                                    }
                                                  },
                                                  child: Icon(value.ids.contains(widget.id)? EvaIcons.heart:EvaIcons.heartOutline,),
                                                );
                                              },
                                            )),
                                        Positioned(
                                            bottom: 0,
                                            right: 0,
                                            left: 0,
                                            height: height * 0.37,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: List<Widget>.generate(
                                                  sneaker.imageUrl.length,
                                                  (index) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 4),
                                                        child: CircleAvatar(
                                                          radius: 5,
                                                          backgroundColor:
                                                              value.activePage !=
                                                                      index
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                      )),
                                            )),
                                      ],
                                    );
                                  }),
                            ),
                            Positioned(
                              bottom: 40,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(
                                    30,
                                  ),
                                ),
                                child: Container(
                                  height: height * 0.645,
                                  width: width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, left: 12, right: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sneaker.name,
                                          style: AppStyle(30, Colors.black,
                                              FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              sneaker.category,
                                              style: AppStyle(20, Colors.grey,
                                                  FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            RatingBar.builder(
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 22,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                      Icons.star,
                                                      color: Colors.black,
                                                      size: 18,
                                                    ),
                                                onRatingUpdate: (rating) {})
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${sneaker.price}",
                                              style: AppStyle(25, Colors.black,
                                                  FontWeight.w600),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Color",
                                                  style: AppStyle(
                                                      18,
                                                      Colors.black,
                                                      FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.black,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.red,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Select Sizes",
                                                  style: AppStyle(
                                                      20,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "View size guide",
                                                  style: AppStyle(
                                                      20,
                                                      Colors.grey,
                                                      FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * 0.012,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: ListView.builder(
                                                  itemCount: value
                                                      .shoeSize.length,
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final size = value
                                                        .shoeSize[index];
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8.0),
                                                      child: ChoiceChip(
                                                        showCheckmark: false,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          side: const BorderSide(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        disabledColor:
                                                            Colors.white,
                                                        label: Text(
                                                          value
                                                                  .shoeSize[
                                                              index]['size'],
                                                          style: AppStyle(
                                                              18,
                                                              size['isSelected']
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black,
                                                              FontWeight.w500),
                                                        ),
                                                        selectedColor:
                                                            Colors.black,
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                                vertical: 8),
                                                        selected:
                                                            size['isSelected'],
                                                        onSelected: (newState) {
                                                          if (value
                                                              .size
                                                              .contains(size[
                                                                  'size'])) {
                                                            value.size
                                                                .remove(size[
                                                                    'size']);
                                                          } else {
                                                            value.size
                                                                .add(size[
                                                                    'size']);
                                                          }
                                                          value
                                                              .toggleCheck(
                                                                  index);
                                                        },
                                                      ),
                                                    );
                                                  }),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        const Divider(
                                          indent: 10,
                                          endIndent: 10,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        SizedBox(
                                          width: width * 0.8,
                                          child: Text(
                                            sneaker.title,
                                            style: AppStyle(20, Colors.black,
                                                FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Text(
                                          sneaker.description,
                                          style: AppStyle(14, Colors.grey,
                                              FontWeight.normal),
                                          maxLines: 5,
                                          textAlign: TextAlign.justify,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                top: height * 0.025),
                                            child: CheckOutButton(
                                              width: width,
                                              onTap: () async {
                                                cartProvider.createCart({
                                                  'id': sneaker.id,
                                                  'name': sneaker.name,
                                                  'category': sneaker.category,
                                                  'sizes':
                                                  value.size[0],
                                                  'imageUrl':
                                                      sneaker.imageUrl[0],
                                                  'price': sneaker.price,
                                                  'qty': 1
                                                });
                                                value.size.clear();
                                                Navigator.pop(context);
                                              },
                                              name: "Add to Cart",
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}

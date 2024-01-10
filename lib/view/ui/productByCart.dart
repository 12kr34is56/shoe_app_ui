import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shoeapp/services/helpers.dart';
import 'package:shoeapp/view/shared/appStyle.dart';
import 'package:shoeapp/view/shared/categoryButton.dart';
import 'package:shoeapp/view/shared/customSpacer.dart';
import 'package:shoeapp/view/shared/latestNews.dart';

import '../../controller/productProvider.dart';
import '../../models/sneakerModel.dart';

class ProductByCart extends StatefulWidget {
  const ProductByCart({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  State<ProductByCart> createState() => _ProductByCartState();
}

class _ProductByCartState extends State<ProductByCart>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
    _tabController.index = widget.tabIndex;

  }

  List<String> brand = [
    "images/adidas.png",
    "images/gucci.png",
    "images/jordan.png",
    "images/jordan.png",
  ];

  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context);
    productProvider.getMale();
    productProvider.getFemale();
    productProvider.getKids();
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 35, 0, 0),
              height: MediaQuery.sizeOf(context).height * 0.4,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/realTop1.png'),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(6, 6, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: Icon(
                            FontAwesomeIcons.sliders,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  TabBar(
                      padding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: Colors.white,
                      labelStyle: AppStyle(24, Colors.white, FontWeight.bold),
                      unselectedLabelColor: Colors.grey.withOpacity(1),
                      tabs: [
                        const Tab(
                          text: 'Men Shoes',
                        ),
                        const Tab(text: 'Women Shoes'),
                        const Tab(text: 'Kids Shoes'),
                      ]),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 12,
                top: MediaQuery.sizeOf(context).height * 0.22,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: TabBarView(controller: _tabController, children: [
                  LatestNews(male: productProvider.male, height: height),
                  LatestNews(male: productProvider.female, height: height),
                  LatestNews(male: productProvider.kids, height: height),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    double _value = 100;
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: MediaQuery.sizeOf(context).height * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black38),
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.75,
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    children: [
                      customSpacer(),
                      Text(
                        'Filter',
                        style: AppStyle(40, Colors.black, FontWeight.bold),
                      ),
                      customSpacer(),
                      Text(
                        'Gender',
                        style: AppStyle(20, Colors.black, FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          CategoryButton(color: Colors.black, name: "Mens"),
                          CategoryButton(color: Colors.grey, name: "Women"),
                          CategoryButton(color: Colors.grey, name: "Kids"),
                        ],
                      ),
                      customSpacer(),
                      Text(
                        'Category',
                        style: AppStyle(20, Colors.black, FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          CategoryButton(color: Colors.black, name: "Shoes"),
                          CategoryButton(color: Colors.grey, name: "Apparrels"),
                          CategoryButton(
                              color: Colors.grey, name: "Accessories"),
                        ],
                      ),
                      customSpacer(),
                      Text(
                        'Price',
                        style: AppStyle(20, Colors.black, FontWeight.bold),
                      ),
                      customSpacer(),
                      Slider(
                          value: _value,
                          activeColor: Colors.black,
                          inactiveColor: Colors.grey,
                          max: 500,
                          divisions: 50,
                          label: _value.toString(),
                          secondaryTrackValue: 200,
                          onChanged: (double value) {}),
                      customSpacer(),
                      Text(
                        "Brand",
                        style: AppStyle(20, Colors.black, FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 60,
                        child: ListView.builder(
                            itemCount: brand.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Image.asset(
                                    brand[index],
                                    height: 60,
                                    width: 80,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}

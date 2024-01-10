
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoeapp/controller/productProvider.dart';
import 'package:shoeapp/models/sneakerModel.dart';
import 'package:shoeapp/services/helpers.dart';
import 'package:shoeapp/view/shared/appStyle.dart';
import 'package:shoeapp/view/shared/homeWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final productProvider = Provider.of<ProductProvider>(context);
    productProvider.getKids();
    productProvider.getFemale();
    productProvider.getMale();
   return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 25, 0, 0),
                height: MediaQuery.sizeOf(context).height * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/realTop1.png'),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 10, bottom: 15),
                  width: MediaQuery.sizeOf(context).width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Athletics Shoe",
                          style: AppStyleWithht(
                              40, Colors.white, FontWeight.bold, 1.2),
                        ),
                        Text(
                          "Collection",
                          style: AppStyleWithht(
                              40, Colors.white, FontWeight.bold, 1.2),
                        ),
                        SizedBox(
                          height: height * 0.007,
                        ),
                        TabBar(
                            padding: EdgeInsets.zero,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: Colors.transparent,
                            controller: _tabController,
                            isScrollable: true,
                            labelColor: Colors.white,
                            labelStyle:
                                AppStyle(24, Colors.white, FontWeight.bold),
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
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * 0.265),
                child: Container(
                  padding: const EdgeInsets.only(left: 12),
                  child: TabBarView(controller: _tabController, children: [
                    HomeWidget(male: productProvider.male,tabIndex:0),
                    HomeWidget(male: productProvider.female,tabIndex: 1),
                    HomeWidget(male: productProvider.kids,tabIndex: 2),

                  ]),
                ),
              ),
            ],
          ),
        ));
  }
}


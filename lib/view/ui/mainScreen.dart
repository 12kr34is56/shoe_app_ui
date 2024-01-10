import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoeapp/controller/mainScreenProvider.dart';
import 'package:shoeapp/view/shared/appStyle.dart';
import 'package:shoeapp/view/shared/bottomNav.dart';
import 'package:shoeapp/view/shared/bottomNavWidget.dart';
import 'package:shoeapp/view/ui/cart.dart';
import 'package:shoeapp/view/ui/favorite.dart';
import 'package:shoeapp/view/ui/homePage.dart';
import 'package:shoeapp/view/ui/productByCart.dart';
import 'package:shoeapp/view/ui/profile.dart';
import 'package:shoeapp/view/ui/searchPage.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  List<Widget> pageList = [
    HomeScreen(),
    SearchScreen(),
    favoritePage(),
    CartPage(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),
          body: pageList[value.index],
          bottomNavigationBar: BottomNav(),
        );
      },
    );
  }
}

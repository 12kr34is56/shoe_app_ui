import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shoeapp/controller/mainScreenProvider.dart';
import 'package:shoeapp/view/shared/bottomNavWidget.dart';
import 'package:ionicons/ionicons.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenProvider>(builder: (context,value,child){
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomNavWidget(
                    onTap: () {
                      value.setIndex(0);
                    },
                    icon: value.index == 0 ? Icons.home : Icons.home_outlined),
                BottomNavWidget(
                    onTap: () {
                      value.setIndex(1);
                    },
                    icon: value.index == 1 ? CupertinoIcons.search_circle_fill : CupertinoIcons.search_circle),
                BottomNavWidget(
                    onTap: () {
                      value.setIndex(2);
                    },
                    icon: value.index == 2 ? EvaIcons.heart : EvaIcons.heartOutline),
                BottomNavWidget(
                    onTap: () {
                      value.setIndex(3);
                    },
                    icon: value.index == 3 ? Icons.shopping_cart : Icons.shopping_cart_outlined),
                BottomNavWidget(
                    onTap: () {
                      value.setIndex(4);
                    },
                    icon: value.index == 4 ? Icons.person : Icons.person_outline),
              ],
            ),
          ),
        ),
      );
    });
  }
}

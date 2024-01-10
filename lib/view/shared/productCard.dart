import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shoeapp/controller/favoriteProvider.dart';
import 'package:shoeapp/models/constants.dart';
import 'package:shoeapp/view/shared/appStyle.dart';
import 'package:shoeapp/view/ui/favorite.dart';
import 'package:shoeapp/view/ui/productPage.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen(
      {super.key,
      required this.price,
      required this.category,
      required this.id,
      required this.name,
      required this.image});

  final String price;
  final String category;
  final String id;
  final String name;
  final String image;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {


  final _favBox = Hive.box('fav_box');

  Future<void> _createFav(Map<String,dynamic> addFav)async{
    await _favBox.add(addFav);
     }




  @override
  Widget build(BuildContext context) {
    bool selected = true;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final favoriteProvider = Provider.of<FavoriteProvider>(context,listen: true);
    favoriteProvider.getFavorite();
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8,0,20,0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: height,
            width: width * 0.6,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.white, //todo color black try
                offset: Offset(1, 1),
                spreadRadius: 1,
                blurRadius: 0.6,

              ),
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: height * 0.20,
                      decoration: BoxDecoration(
                          image:
                              DecorationImage(image: NetworkImage(widget.image))),
                    ),
                    Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            if(favoriteProvider.ids.contains(widget.id)){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>favoritePage()));
                            }else{
                              favoriteProvider.createFav({
                                "id" : widget.id,
                                "name" : widget.name,
                                "category" : widget.category,
                                "price" : widget.price,
                                "imageUrl" : widget.image,
                              }
                              );
                              // setState(() {
                              //
                              // });
                            }
                          },
                          child: Icon(favoriteProvider.ids.contains(widget.id)? EvaIcons.heart:EvaIcons.heartOutline,),),)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style:
                            AppStyleWithht(30, Colors.black, FontWeight.bold, 1.1),
                      ),
                      Text(
                        widget.category,
                        style:
                            AppStyleWithht(18, Colors.grey, FontWeight.bold, 1.5),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.price,
                        style: AppStyle(20, Colors.black87, FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            'Color',
                            style: AppStyle(18, Colors.grey, FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          ChoiceChip(
                            label: const Text(''),
                            selected: selected,
                            visualDensity: VisualDensity.compact,
                            selectedColor: Colors.black,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

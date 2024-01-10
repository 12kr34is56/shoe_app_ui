import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoeapp/controller/favoriteProvider.dart';
import 'package:shoeapp/view/shared/appStyle.dart';
import 'package:shoeapp/view/ui/mainScreen.dart';

import '../../models/constants.dart';

class favoritePage extends StatefulWidget {
  const favoritePage({super.key});

  @override
  State<favoritePage> createState() => _favoritePageState();
}

class _favoritePageState extends State<favoritePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: true);
    favoriteProvider.getAllData();
    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 25, 0, 0),
              height: MediaQuery.sizeOf(context).height * 0.4,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/realTop1.png'),
                ),
              ),
              child: Text(
                "My Favorite",
                style: AppStyle(40, Colors.white, FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: ListView.builder(
                  itemCount: favoriteProvider.fav.length,
                  padding: EdgeInsets.only(top: height * 0.1),
                  itemBuilder: (context, index) {
                    final shoe = favoriteProvider.fav[index];
                    return Padding(
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
                                  color: Colors.grey.shade500,
                                  offset: Offset(0, 1),
                                  spreadRadius: 5,
                                  blurRadius: 0.3,
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 12, left: 12, bottom: 12),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: AlignmentDirectional
                                                  .topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [

                                            Colors.grey.shade300,
                                                Colors.white,
                                          ])),
                                      child: CachedNetworkImage(
                                        imageUrl: shoe['imageUrl'],
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 12, left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          shoe['name'],
                                          style: AppStyle(16, Colors.black,
                                              FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                          shoe['category'],
                                          style: AppStyle(
                                              14,
                                              Colors.grey.shade700,
                                              FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(children: [
                                          Text(
                                            shoe['price'],
                                            style: AppStyle(18, Colors.black,
                                                FontWeight.w600),
                                          )
                                        ]),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: InkWell(
                                  onTap: () {
                                    favoriteProvider.deleteFav(shoe['key']);
                                    ids.removeWhere(
                                        (element) => element == shoe['id']);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainScreen()));
                                  },
                                  child: Icon(
                                    CupertinoIcons.heart_slash_fill,
                                    size: 25,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shoeapp/controller/favoriteProvider.dart';
import 'package:shoeapp/controller/mainScreenProvider.dart';
import 'package:shoeapp/controller/productProvider.dart';
import 'package:shoeapp/view/ui/mainScreen.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

import 'controller/cartProvider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory(); //get the location in the phone
  Hive.init(directory.path);
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>MainScreenProvider()),
      ChangeNotifierProvider(create: (_)=>ProductProvider()),
      ChangeNotifierProvider(create: (_)=>FavoriteProvider()),
      ChangeNotifierProvider(create: (_)=>CartProvider()),
    ],child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    ),);
  }
}

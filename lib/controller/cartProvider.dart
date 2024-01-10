

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class CartProvider with ChangeNotifier{

  final _cartBox = Hive.box('cart_box');
  int _counter = 0;
  int get counter => _counter;
  List<dynamic> _cart = [];
  List<dynamic> get cart => _cart;


  set cart(List<dynamic> newList){
    _cart = newList;
    notifyListeners();
  }

  void increament(value){
    _counter++;
    notifyListeners();
  }

  void decreament(value){
    if(_counter >=1){
      _counter--;
    }
    notifyListeners();
  }

  getAllCartData(){

    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "keys": key,
        "name": item['name'],
        "id": item['id'],
        'category': item['category'],
        'imageUrl': item['imageUrl'],
        "price": item['price'],
        "qty": item['qty'],
        "sizes": item['sizes']
      };
    }).toList();

    _cart = cartData.reversed.toList();
  }

  Future<void>delete(int key)async{
    await _cartBox.delete(key);
  }

  Future<void> createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

 }
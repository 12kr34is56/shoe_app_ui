
import 'package:flutter/material.dart';
import 'dart:core';

import '../models/sneakerModel.dart';
import '../services/helpers.dart';
class ProductProvider with ChangeNotifier{

  int _activePage = 0;
  int get activePage => _activePage;
  void setPage(value){
    _activePage = value;
    notifyListeners();
  }

  List<dynamic> _shoeSize = [];

  List<dynamic> get shoeSize => _shoeSize;

  set shoeSize(List<dynamic> newSize){
    _shoeSize = newSize;
    notifyListeners();
  }


  void toggleCheck(int index){

    for(int i = 0; i < _shoeSize.length ; i++){
        if(i == index){
          _shoeSize[i]['isSelected'] = !_shoeSize[i]['isSelected'];
        }
    }
    notifyListeners();
  }


  List<String> _size=[];

  List<String> get size => _size;

  set size(List<String> newSize){
    _size = newSize;
    notifyListeners();
  }

  late Future<List<SneakersModel>> male;
  late Future<List<SneakersModel>> female;
  late Future<List<SneakersModel>> kids;
  late Future<SneakersModel> sneakers;

  void getMale() {
    male = Helper().getMaleSneakers();
  }
  void getFemale(){
    female = Helper().getFemaleSneakers();

  }  void getKids() {
    kids = Helper().getKidsSneakers();

  }

  void getShoes(String category,String id) {
    if (category == "Men's Running") {
      sneakers = Helper().getMaleSneakersById(id);
    } else if (category == "Women's Running") {
      sneakers = Helper().geFemaleSneakersById(id);
    } else {
      sneakers = Helper().getKidsSneakersById(id);
    }
  }

}
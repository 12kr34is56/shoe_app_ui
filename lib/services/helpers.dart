import 'package:flutter/services.dart' as the_bundels;
import 'package:shoeapp/models/sneakerModel.dart';


//this class help to fetch the data from the json file

class Helper{

  //male
  Future<List<SneakersModel>> getMaleSneakers()async{

    final data = await the_bundels.rootBundle.loadString('json/men_shoes.json');

    final maleList = sneakersModelFromJson(data);

    return maleList;
  }

  //Female
  Future<List<SneakersModel>> getFemaleSneakers()async{

    final data = await the_bundels.rootBundle.loadString('json/women_shoes.json');

    final femaleList = sneakersModelFromJson(data);

    return femaleList;
  }

  //Kids
  Future<List<SneakersModel>> getKidsSneakers()async{

    final data = await the_bundels.rootBundle.loadString('json/kids_shoes.json');

    final kidsList = sneakersModelFromJson(data);

    return kidsList;
  }

  //Single Male
  Future<SneakersModel> getMaleSneakersById(String id)async{

    final data = await the_bundels.rootBundle.loadString('json/men_shoes.json');

    final maleList = sneakersModelFromJson(data);

    final sneakers = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneakers;
  }

  //Single female
  Future<SneakersModel> geFemaleSneakersById(String id)async{

    final data = await the_bundels.rootBundle.loadString('json/women_shoes.json');

    final femaleList = sneakersModelFromJson(data);

    final sneakers = femaleList.firstWhere((sneaker) => sneaker.id == id);

    return sneakers;
  }

 //Single kids
  Future<SneakersModel> getKidsSneakersById(String id)async{

    final data = await the_bundels.rootBundle.loadString('json/kids_shoes.json');

    final kidsList = sneakersModelFromJson(data);

    final sneakers = kidsList.firstWhere((sneaker) => sneaker.id == id);

    return sneakers;
  }
}
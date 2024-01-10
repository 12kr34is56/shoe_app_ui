
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class FavoriteProvider with ChangeNotifier {
  final _favBox = Hive.box('fav_box');

  List<dynamic> _ids = [];
  List<dynamic> _favorite = [];
  List<dynamic> _fav = [];

  List<dynamic> get ids => _ids;
  List<dynamic> get favorite => _favorite;
  List<dynamic> get fav => _fav;

  set ids(List<dynamic> newList) {
    _ids = newList;
    notifyListeners();
  }

  set favorite(List<dynamic> newList) {
    _favorite = newList;
    notifyListeners();
  }

  set fav(List<dynamic> newList) {
    _fav = newList;
    notifyListeners();
  }


  Future<void>deleteFav(int key) async {
    await _favBox.delete(key);
  }

  getFavorite() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);

      return {"key": key, "id": item['id']};
    }).toList();

    _favorite = favData.toList();
    ids = _favorite.map((item) => item['id']).toList();
  }

  Future<void> createFav(Map<String, dynamic> addFav) async {
    await _favBox.add(addFav);
  }

  getAllData() {
    final favData = _favBox.keys.map((key) {
      final item = _favBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "name": item['name'],
        'category': item['category'],
        'imageUrl': item['imageUrl'],
        "price": item['price']
      };
    }).toList();

    _fav = favData.reversed.toList();
  }
}

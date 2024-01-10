

import 'package:flutter/cupertino.dart';

class MainScreenProvider extends ChangeNotifier{

  int _index = 0;

  int get index => _index;

  void setIndex(value){
    _index = value;
    notifyListeners();
  }
}
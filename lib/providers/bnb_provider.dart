

import 'package:flutter/material.dart';

class BNBProvider extends ChangeNotifier {
  int _index = 0;
  int get currentIndex => _index;

  setIndex(int index) {
   _index = index;
    notifyListeners();
  }
}

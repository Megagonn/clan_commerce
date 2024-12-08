

import 'package:flutter/material.dart';

class BNBProvider extends ChangeNotifier {
  ///Just the bottom nav bar provider
  ///it updates the currentInde of the nav bar
  int _index = 0;
  int get currentIndex => _index;

  setIndex(int index) {
   _index = index;
    notifyListeners();
  }
}

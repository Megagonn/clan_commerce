import 'dart:developer';

import 'package:clan_commerce/stock.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  String _category = 'all';
  String get category => _category;
  List _items = gadgets;
  List get items => _items;

  setCategory(String category) {
    print(category);
    _category = category;

    notifyListeners();
  }

  getItems() {
    _items = _category == 'all' ? gadgets : gadgets.where((e) => e['category'] == _category).toList();
    log(_items.toString());
    notifyListeners();
  }
}

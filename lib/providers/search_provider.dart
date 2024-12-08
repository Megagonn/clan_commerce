

// ignore_for_file: prefer_final_fields

import 'package:clan_commerce/stock.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  List _items = gadgets;
  List _searchResult = [];
  List get searchResult => _searchResult;
  List get items => _items;

  searchItems(String keyword) {
    // print(search);
  ///Filter the item list with supplied keyword.
    _searchResult = _items.where((item)=> item['name'].toString().toLowerCase().contains(keyword.toLowerCase()) || item['description'].toString().toLowerCase().contains(keyword.toLowerCase())).toList();

    notifyListeners();
  }

  
}

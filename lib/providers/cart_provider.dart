import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  List _cart = [];
  List get cart => _cart;
  int _itemCount = 0;
  int get itemCount => _itemCount;
  bool _inCart = false;
  bool get inCart => _inCart;
  double _total = 0;
  double get total => _total;

  ///This method add new item to cart.
  setcart(Map cart) async {
    cart['count'] = 1;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List oldCart = jsonDecode(preferences.getString('cart') ?? "[]");
    oldCart.add(cart);
    preferences.setString('cart', jsonEncode(oldCart));
    isInCart(cart['itemId']);
    getEachItemCount(cart['itemId']);
    notifyListeners();
  }

  ///This method empty the cart
  clearCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('cart', jsonEncode([]));
    getItems();
    getTotal();
    notifyListeners();
  }

  getEachItemCount(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List oldCart = jsonDecode(preferences.getString('cart') ?? "[]");
    var item = oldCart.where((element) => element['itemId'] == id).firstOrNull;
    _itemCount = item == null ? 0 : item['count'];

    notifyListeners();
  }

  ///This method calculate the total price of items in cart
  getTotal() async {
    _total = 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List oldCart = jsonDecode(preferences.getString('cart') ?? "[]");
    for (var i = 0; i < oldCart.length; i++) {
      var each = oldCart[i]['discountPrice'] * oldCart[i]['count'];
      _total += each;
    }

    notifyListeners();
  }

  ///This method check if the item displayed in ItemDetails is already in cart.
  isInCart(String id) async {
    _inCart = false;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List oldCart = jsonDecode(preferences.getString('cart') ?? "[]");
    List item = oldCart.where((element) => element['itemId'] == id).toList();
    _inCart = item.isNotEmpty;

    notifyListeners();
  }

  getItems() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List fetchCart = jsonDecode(preferences.getString('cart') ?? "[]");
    _cart = fetchCart;
    notifyListeners();
  }

  ///This method increase the count of selected item in cart
  increment(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List fetchCart = jsonDecode(preferences.getString('cart') ?? "[]");
    int itemIndex = fetchCart.indexWhere((element) => element['itemId'] == id);
    Map item = fetchCart.where((element) => element['itemId'] == id).first;
    log(item.toString());
    item['count']++;
    fetchCart.removeAt(itemIndex);
    fetchCart.insert(itemIndex, item);
    preferences.setString('cart', jsonEncode(fetchCart));
    _cart = fetchCart;
    getEachItemCount(id);
    getTotal();
    notifyListeners();
  }

  ///This method decrease the count of selected item in cart
  decrement(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List fetchCart = jsonDecode(preferences.getString('cart') ?? "[]");
    int itemIndex = fetchCart.indexWhere((element) => element['itemId'] == id);
    Map item = fetchCart.where((element) => element['itemId'] == id).first;
    log(item.toString());
    item['count'] > 1 ? item['count']-- : null;
    fetchCart.removeAt(itemIndex);
    fetchCart.insert(itemIndex, item);
    preferences.setString('cart', jsonEncode(fetchCart));
    _cart = fetchCart;
    getEachItemCount(id);
    getTotal();
    notifyListeners();
  }

  ///This method remove items from cart
  remove(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List fetchCart = jsonDecode(preferences.getString('cart') ?? "[]");
    fetchCart.removeWhere((element) => element['itemId'] == id);
    preferences.setString('cart', jsonEncode(fetchCart));
    _cart = fetchCart;
    getTotal();
    notifyListeners();
  }
}

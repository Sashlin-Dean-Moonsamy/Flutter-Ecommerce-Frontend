import 'package:flutter/material.dart';
import 'package:lux/models/product.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cart = [];

  List<Product> get cart => _cart;

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners(); // Notifies UI to update
  }
}

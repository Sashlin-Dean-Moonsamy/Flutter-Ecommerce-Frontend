import 'package:flutter/material.dart';
import 'package:lux/models/product.dart';
import 'package:lux/models/order_item.dart';

class CartProvider with ChangeNotifier {
  final List<OrderItem> _cart = [];

  List<OrderItem> get cart => _cart;

  double get totalPrice {
    return _cart.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  void addToCart(Product product) {
    // Check if the product is already in the cart
    final existingProductIndex = _cart.indexWhere((item) => item.product.id == product.id);

    if (existingProductIndex != -1) {
      // If product exists, increase the quantity of the order item
      _cart[existingProductIndex].quantity += 1;
    } else {
      // If product doesn't exist, add it with quantity 1
      _cart.add(OrderItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    // Check if the product is already in the cart
    final existingProductIndex = _cart.indexWhere((item) => item.product.id == product.id);

    if (existingProductIndex != -1) {
      // If product exists and quantity > 1, decrease the quantity
      if (_cart[existingProductIndex].quantity > 1) {
        _cart[existingProductIndex].quantity -= 1;
      } else {
        // If quantity is 1, remove the product from the cart
        _cart.removeAt(existingProductIndex);
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}

import 'package:lux/models/product.dart';

class OrderItem {
  final Product product;
  int quantity;

  OrderItem({
    required this.product,
    this.quantity = 1,
  });
}

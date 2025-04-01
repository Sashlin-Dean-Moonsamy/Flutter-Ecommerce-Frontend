import 'package:flutter/material.dart';
import 'package:lux/models/product.dart';
import 'package:provider/provider.dart';
import 'package:lux/providers/cart_provider.dart';
import 'package:lux/models/order_item.dart';

class Detail extends StatelessWidget {
  final Product product;
  const Detail({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final existingOrderItem = cartProvider.cart.firstWhere(
          (item) => item.product.id == product.id,
      orElse: () => OrderItem(product: product, quantity: 0),
    );

    return Scaffold(
      appBar: AppBar(title: Text(product.name), actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                  errorBuilder: (_, __, ___) => Image.asset('assets/images/imageNotFound.jpg', fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(product.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text("Price: \$${product.price}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: existingOrderItem.quantity > 0
                  ? Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => _updateCart(context, cartProvider.removeFromCart, product),
                      icon: const Icon(Icons.remove, color: Colors.black),
                    ),
                    Text(
                      '${existingOrderItem.quantity}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    IconButton(
                      onPressed: () => _updateCart(context, cartProvider.addToCart, product),
                      icon: const Icon(Icons.add, color: Colors.black),
                    ),
                  ],
                ),
              )
                  : ElevatedButton(
                onPressed: () => _updateCart(context, cartProvider.addToCart, product),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: const Text("Add to Cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateCart(BuildContext context, Function(Product) action, Product product) {
    action(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${product.name} updated in cart!"), duration: const Duration(seconds: 1)),
    );
  }
}

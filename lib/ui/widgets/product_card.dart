import 'package:flutter/material.dart';
import 'package:lux/models/product.dart';
import 'package:provider/provider.dart';
import 'package:lux/providers/cart_provider.dart';
import 'package:lux/models/order_item.dart';
import 'package:lux/ui/screens/detail.dart'; // Import the detail page

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final existingOrderItem = cartProvider.cart.firstWhere(
          (item) => item.product.id == product.id,
      orElse: () => OrderItem(product: product, quantity: 0),
    );

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Detail(product: product),
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        height: 350,
        child: Card(
          color: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (_, __, ___) => Image.asset('assets/images/imageNotFound.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(product.description, style: const TextStyle(fontSize: 16), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text("\$${product.price}", style: const TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, maxLines: 1),
                    ),
                    existingOrderItem.quantity > 0
                        ? Row(
                      children: [
                        IconButton(
                          onPressed: () => _updateCart(context, cartProvider.removeFromCart, product),
                          icon: const Icon(Icons.remove, color: Colors.black),
                        ),
                        Text('${existingOrderItem.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        IconButton(
                          onPressed: () => _updateCart(context, cartProvider.addToCart, product),
                          icon: const Icon(Icons.add, color: Colors.black),
                        ),
                      ],
                    )
                        : _addButton(context, cartProvider, product),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateCart(BuildContext context, Function(Product) action, Product product) {
    action(product);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product.name} quantity updated!'), duration: const Duration(seconds: 1)));
  }

  Widget _addButton(BuildContext context, CartProvider cartProvider, Product product) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(12)),
      child: IconButton(
        onPressed: () => _updateCart(context, cartProvider.addToCart, product),
        icon: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}

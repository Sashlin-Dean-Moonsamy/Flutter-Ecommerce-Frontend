import 'package:flutter/material.dart';
import 'package:lux/models/product.dart';
import 'package:provider/provider.dart';
import 'package:lux/providers/cart_provider.dart';
import 'package:lux/models/order_item.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the cart provider
    final cartProvider = Provider.of<CartProvider>(context);

    // Get the order item corresponding to the product in the cart (or null if not present)
    final existingOrderItem = cartProvider.cart.firstWhere(
          (item) => item.product.id == product.id,
      orElse: () => OrderItem(product: product, quantity: 0),
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
      height: 350, // Fixed height to prevent overflow
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensures it only takes necessary space
            children: [
              // Image Section
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/imageNotFound.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Product Name & Description
              Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // Prevents overflow
              ),
              const SizedBox(height: 10),

              // Price & Button Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${product.price}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  existingOrderItem.quantity > 0
                      ? Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          cartProvider.removeFromCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.name} quantity updated!'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: const Icon(Icons.remove, color: Colors.black),
                      ),
                      Text(
                        '${existingOrderItem.quantity}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          cartProvider.addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.name} quantity updated!'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add, color: Colors.black),
                      ),
                    ],
                  )
                      : Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        cartProvider.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} added to cart!'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lux/ui/widgets/product_card.dart';
import 'package:lux/models/product.dart';

class ProductGrid extends StatelessWidget {
  final List<Product>? products; // This can be null if we're using FutureBuilder
  final Future<List<Product>>? productsFuture; // This can be null if we're passing products directly

  const ProductGrid ({
    Key? key,
    this.products,
    this.productsFuture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (productsFuture != null) {
      // If we have a Future<List<Product>>, use FutureBuilder
      return FutureBuilder<List<Product>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No products found"));
          }

          return _buildGridView(snapshot.data!);
        },
      );
    } else if (products != null) {
      // If we already have the products list, display them directly
      if (products!.isEmpty) {
        return Center(child: Text("No products found"));
      }

      return _buildGridView(products!);
    } else {
      return Center(child: Text("No products available"));
    }
  }

  Widget _buildGridView(List<Product> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 16.0, // Horizontal spacing between cards
        mainAxisSpacing: 16.0, // Vertical spacing between cards
        childAspectRatio: 0.75, // Adjust card height to width ratio
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lux/ui/widgets/product_card.dart';
import 'package:lux/models/product.dart';

class ProductList extends StatelessWidget {
  final List<Product>? products; // This can be null if we're using FutureBuilder
  final Future<List<Product>>? productsFuture; // This can be null if we're passing products directly

  const ProductList({
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

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ProductCard(product: snapshot.data![index]);
            },
          );
        },
      );
    } else if (products != null) {
      // If we already have the products list, display them directly
      if (products!.isEmpty) {
        return Center(child: Text("No products found"));
      }

      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products!.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products![index]);
        },
      );
    } else {
      return Center(child: Text("No products available"));
    }
  }
}

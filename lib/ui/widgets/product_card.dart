import 'package:flutter/material.dart';
import 'package:lux/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(product.image, height: 100, width: 100, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text("\$${product.price}"),
        ],
      ),
    );
  }
}

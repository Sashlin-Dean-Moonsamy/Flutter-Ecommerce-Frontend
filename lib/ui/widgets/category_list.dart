import 'package:flutter/material.dart';
import 'package:lux/ui/widgets/product_card.dart';

class CategoryList extends StatelessWidget {
  final List<dynamic> categories;

  const CategoryList({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                category['name'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200, // Height for horizontal product list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (category['products'] as List?)?.length ?? 0,
                itemBuilder: (context, productIndex) {
                  final product = category['products'][productIndex];
                  return ProductCard(product: product);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

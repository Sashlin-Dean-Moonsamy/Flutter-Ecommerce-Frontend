import 'package:flutter/material.dart';
import 'package:lux/ui/widgets/product_card.dart';

class PopularProductList extends StatelessWidget {
  final List<dynamic> popularProducts;

  const PopularProductList({Key? key, required this.popularProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:  ListView.builder(
            itemCount: popularProducts.length,
            itemBuilder: (contect, index){
              final product = popularProducts[index];

              return ProductCard(product: product);
            }));
  }
}

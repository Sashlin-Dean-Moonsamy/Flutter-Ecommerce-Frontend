import 'package:flutter/material.dart';
import 'package:lux/ui/widgets/product_card.dart';
import 'package:lux/models/product.dart';

class PopularProductList extends StatelessWidget {
  final Future<List<Product>> popularProductsFuture;

  const PopularProductList({Key? key, required this.popularProductsFuture})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: popularProductsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No popular products found"));
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return  ProductCard(product: snapshot.data![index], onRemove: () {  },);
            },
        );
      },
    );
  }
}

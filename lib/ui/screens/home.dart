import 'package:flutter/material.dart';
import 'package:lux/services/product.dart';
import 'package:lux/ui/widgets/product_list.dart';  // Use ProductList instead of ProductGrid
import 'package:lux/ui/widgets/lux_drawer.dart';
import 'package:lux/models/product.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  final productsService = ProductService();
  late Future<List<Product>> _popularProductsFuture;

  @override
  void initState() {
    super.initState();
    _popularProductsFuture = ProductService.fetchPopularProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lux'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      drawer: LuxDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Center the title text horizontally
            Center(
              child: const Text(
                "Premium Selection",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            // FutureBuilder with error and empty data handling
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: _popularProductsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No products available"));
                  }

                  return ProductList(
                    productsFuture: Future.value(snapshot.data!),  // Passing fetched products
                  );
                },
              ),
            ),

            // Center the "Browse Shop" button
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/shop');
                  },
                  child: const Text('Browse Shop'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


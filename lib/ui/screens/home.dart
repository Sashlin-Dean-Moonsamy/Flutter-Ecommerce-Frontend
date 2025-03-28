import 'package:flutter/material.dart';
import 'package:lux/services/product.dart';
import 'package:lux/ui/widgets/product_list.dart';
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
          children: [
            const Text(
              "Premium Selection",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // FutureBuilder with error and empty data handling
            SizedBox(
              height: 550,
              child: ProductList(
                productsFuture: _popularProductsFuture,
              ),
            ),

            // Button to navigate to the Shop screen
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/shop');
                },
                child: const Text('Browse Shop'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

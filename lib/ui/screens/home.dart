import 'package:flutter/material.dart';
import 'package:lux/services/popular_products.dart';
import 'package:lux/ui/widgets/popular_product_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  final popularProductsService = PopularProductsService();
  late Future<List<dynamic>> _popularProductsFuture;

  @override
  void initState() {
    super.initState();
    _popularProductsFuture = popularProductsService.fetchPopularProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lux')),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Icon(Icons.favorite, size: 50, color: Colors.white),
            ),
            _buildDrawerItem(Icons.home, "Home", '/home'),
            _buildDrawerItem(Icons.shop, "Shop", '/shop'),
            _buildDrawerItem(Icons.phone, "Contact", '/contact'),
          ],
        ),
      ),
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
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _popularProductsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No popular products found"));
                  }
                  return PopularProductList(popularProducts: snapshot.data!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Drawer item builder
  Widget _buildDrawerItem(IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: const TextStyle(color: Colors.black)),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}

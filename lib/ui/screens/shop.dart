import 'package:flutter/material.dart';
import 'package:lux/services/category.dart';
import 'package:lux/services/product.dart';
import 'package:lux/ui/widgets/category_list.dart';
import 'package:lux/ui/widgets/product_card.dart';
import 'package:lux/models/category.dart';
import 'package:lux/models/product.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<Shop> {
  final CategoryService _categoryService = CategoryService();
  final ProductService _productService = ProductService();

  late Future<List<Category>> _categoriesFuture;
  late Future<List<Product>> _productsFuture;

  String _selectedCategory = "All"; // Track selected category
  String _searchQuery = ""; // Track search query

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _categoryService.fetchCategories();
    _productsFuture = _productService.fetchProducts(); // Fetch all products initially
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
      _fetchFilteredProducts(); // Update product list based on category
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _fetchFilteredProducts(); // Update product list based on search query
    });
  }

  void _fetchFilteredProducts() {
    setState(() {
      _productsFuture = _productService.fetchProducts(
        category: _selectedCategory == "All" ? null : _selectedCategory,
        searchQuery: _searchQuery.isEmpty ? null : _searchQuery,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shop")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: "Search products...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),

            // Category List
            FutureBuilder<List<Category>>(
              future: _categoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No categories found"));
                }

                List<String> categories = ["All"] + snapshot.data!.map((cat) => cat.name).toList();

                return CategoryList(
                  categories: categories,
                  onCategorySelected: _onCategorySelected,
                );
              },
            ),
            const SizedBox(height: 16),

            // Product List
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No products found"));
                  }

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Show two products per row
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: snapshot.data![index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

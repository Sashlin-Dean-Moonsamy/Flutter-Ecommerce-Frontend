import 'package:flutter/material.dart';
import 'package:lux/models/category.dart';
import 'package:lux/models/product.dart';
import 'package:lux/services/category.dart';
import 'package:lux/ui/widgets/product_list.dart';

class Shop extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<Shop> {
  final CategoryService _categoryService = CategoryService();
  List<Category> _categories = [];
  List<Product>? _products;
  String? _selectedCategory;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Category> categories = await _categoryService.fetchCategories();
      setState(() {
        _categories = categories;
        // Automatically load products from the first category
        if (_categories.isNotEmpty) {
          _loadProducts(_categories[0].name);
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error loading categories: $e");
    }
  }

  Future<void> _loadProducts(String categoryName) async {
    setState(() {
      _isLoading = true;
      _selectedCategory = categoryName;
    });
    try {
      List<Product> products = [];
      for (var category in _categories) {
        if (category.name == categoryName) {
          products.addAll(category.products);
        }
      }
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error loading products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                bool isSelected = _selectedCategory == _categories[index].name;
                return GestureDetector(
                  onTap: () => _loadProducts(_categories[index].name),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.grey.shade200: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        _categories[index].name,
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _products == null
                ? Center(child: Text("Select a category"))
                : _products!.isEmpty
                ? Center(child: Text("No products found"))
                : ProductList(products: _products),
          ),
        ],
      ),
    );
  }
}

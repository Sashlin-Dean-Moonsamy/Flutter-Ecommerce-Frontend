import 'package:flutter/material.dart';
import 'package:lux/models/category.dart';
import 'package:lux/models/product.dart';
import 'package:lux/services/category.dart';
import 'package:lux/ui/widgets/product_grid.dart';
import 'package:lux/services/product.dart';

class Shop extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<Shop> {
  final CategoryService _categoryService = CategoryService();
  List<Category> _categories = [];
  List<Product>? _categoryProducts;
  List<Product>? _allProducts;
  List<Product>? _filteredProducts;
  String? _selectedCategory;
  bool _isLoading = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Category> categories = await _categoryService.fetchCategories();
      setState(() {
        _categories = categories;
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
        _categoryProducts = products;
        _filteredProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error loading products: $e");
    }
  }

  void _filterProducts() async {
    setState(() {
      _isLoading = true;
    });

    if (_searchController.text.isEmpty) {
      setState(() {
        _filteredProducts = _categoryProducts;
        _isLoading = false;
      });
    } else {
      try {
        List<Product> searchedProducts = await ProductService.searchProducts(_searchController.text);
        setState(() {
          _filteredProducts = searchedProducts;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print("Error searching products: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search products...",
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
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
                        color: isSelected ? Colors.grey.shade200 : Colors.transparent,
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
                : _filteredProducts == null
                ? Center(child: Text("Select a category"))
                : _filteredProducts!.isEmpty
                ? Center(child: Text("No products found"))
                : ProductGrid(products: _filteredProducts!),
          ),
        ],
      ),
    );
  }
}

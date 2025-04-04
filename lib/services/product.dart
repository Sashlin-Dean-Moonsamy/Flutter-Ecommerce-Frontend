import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lux/models/product.dart';  // Import the Product model

class ProductService {
  static const String apiUrl =
      'https://django-ecommerce-backend-wgpj.onrender.com/api/products/';

  static Future<List<Product>>  fetchPopularProducts() async {
    final response = await http.get(Uri.parse("${apiUrl}popular/"));

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      if (decoded is List) {
        // Map the JSON list to a list of Product objects
        return decoded.map((json) => Product.fromJson(json)).toList();
      } else if (decoded is Map<String, dynamic> && decoded.containsKey('products')) {
        var productsList = decoded['products'] as List;
        return productsList.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Unexpected response format: $decoded");
      }
    } else {
      throw Exception("Failed to load popular products");
    }
  }

  static Future<List<Product>> searchProducts(String query) async {
    try {
      final response = await http.get(
        Uri.parse('https://django-ecommerce-backend-wgpj.onrender.com/api/products/search?query=$query'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error searching for products: $e');
      return [];
    }
  }
}


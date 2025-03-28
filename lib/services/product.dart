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

  Future<List<Product>> fetchProducts({String? category, String? searchQuery}) async {
    try {
      String url = apiUrl;

      // Add category and search filters if provided
      if (category != null || searchQuery != null) {
        List<String> queryParams = [];
        if (category != null) queryParams.add("category=$category");
        if (searchQuery != null) queryParams.add("search=$searchQuery");
        url += "?${queryParams.join("&")}";
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var decoded = json.decode(response.body);
        print("Products API Response: $decoded"); // Debugging

        if (decoded is List) {
          return decoded.map((json) => Product.fromJson(json)).toList();
        } else if (decoded is Map<String, dynamic> && decoded.containsKey('products')) {
          var productsList = decoded['products'] as List;
          return productsList.map((json) => Product.fromJson(json)).toList();
        } else {
          print("Unexpected response format: $decoded");
          return [];
        }
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (e) {
      print("Network error: $e");
      return [];
    }
  }

}


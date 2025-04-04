import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lux/models/category.dart';  // I
import 'package:lux/models/product.dart';// mport the model file

class CategoryService {
  static const String apiUrl = 'https://django-ecommerce-backend-wgpj.onrender.com/api/categories/';

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      if (decoded is List) {
        // Map the JSON list to a list of Category objects
        return decoded.map((json) => Category.fromJson(json)).toList();
      } else if (decoded is Map<String, dynamic> && decoded.containsKey('categories')) {
        // Handle the case where categories are wrapped inside an object
        var categoriesList = decoded['categories'] as List;
        return categoriesList.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception("Unexpected response format: $decoded");
      }
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<List<Product>> fetchCategory(String categoryName) async {
    final response = await http.get(Uri.parse("$apiUrl$categoryName/products/"));

    if (response.statusCode == 200) {
      // Parse the response body and return the list of Product objects
      List<dynamic> data = json.decode(response.body);
      return data.map((productJson) => Product.fromJson(productJson)).toList();
    } else {
      throw Exception("Failed to load products for category: $categoryName");
    }
  }


}

import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryService {
  static const String baseUrl = "https://django-ecommerce-backend-wgpj.onrender.com/api/catagory/";

  static Future<List<Map<String, dynamic>>> fetchCategories() async {
    final response = await http.get(Uri.parse("$baseUrl/categories/"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data["categories"]);
    } else {
      throw Exception("Failed to load categories");
    }
  }
}

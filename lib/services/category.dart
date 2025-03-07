import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryService {
  static const String apiUrl = 'https://django-ecommerce-backend-wgpj.onrender.com/api/categories/';

  Future<List<dynamic>> fetchCategories() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);

      if (decoded is List) {
        return decoded; // Correct format

      } else if (decoded is Map<String, dynamic> && decoded.containsKey('categories')) {
        return decoded['categories']; // If wrapped inside an object

      } else {
        throw Exception("Unexpected response format: $decoded");
      }

    } else {
      throw Exception("Failed to load categories");
    }
  }

}

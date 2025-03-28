import 'package:flutter_test/flutter_test.dart';
import 'package:lux/services/category.dart';
import 'package:lux/models/category.dart';
import 'package:lux/models/product.dart';

void main() {
  final CategoryService categoryService = CategoryService();

  test('Fetch categories', () async {
    List<Category> categories = await categoryService.fetchCategories();
    expect(categories, isNotEmpty); // Ensure categories are returned
  });

  test('Fetch products for a category', () async {
    List<Category> categories = await categoryService.fetchCategories();
    if (categories.isNotEmpty) {
      List<Product> products = await categoryService.fetchCategory(categories.first.name);
      expect(products, isList); // Ensure result is a list
    }
  });
}

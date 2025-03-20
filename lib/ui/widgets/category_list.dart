import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<String> categories;
  final ValueChanged<String> onCategorySelected;

  const CategoryList({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () => onCategorySelected(categories[index]),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(categories[index], style: TextStyle(color: Colors.white)),
            ),
          );
        },
      ),
    );
  }
}

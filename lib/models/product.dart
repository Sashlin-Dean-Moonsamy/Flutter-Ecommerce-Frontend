class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String image;
  final DateTime dateTimeAdded;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.dateTimeAdded,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price']),
      stock: json['stock'],
      image: json['image'],
      dateTimeAdded: DateTime.parse(json['date_time_added']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

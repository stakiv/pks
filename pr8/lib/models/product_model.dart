class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String feature;
  final bool isFavourite; // Новое поле для изображения

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.feature,
    required this.isFavourite, // Новое поле для изображения
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['ID'],
      name: json['Name'],
      imageUrl: json['ImageURL'],
      description: json['Description'],
      price: json['Price'].toDouble(),
      feature: json['Features'],
      isFavourite: json['IsFavourite'],
      // Предполагаем, что API возвращает это поле
    );
  }
}

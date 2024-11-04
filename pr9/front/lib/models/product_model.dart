class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String feature;
  bool isInCart;
  int quantity;
  bool isFavourite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.feature,
    required this.isInCart,
    required this.quantity,
    required this.isFavourite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['ID'],
      name: json['Name'],
      imageUrl: json['ImageURL'],
      description: json['Description'],
      price: json['Price'].toDouble(),
      feature: json['Features'],
      isInCart: json['IsInCart'],
      quantity: json['Quantity'],
      isFavourite: json['IsFavourite'],
    );
  }
}

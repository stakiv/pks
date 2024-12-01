class OrderProduct {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String feature;
  final int quantity;

  OrderProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.feature,
    required this.quantity,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['product_id'],
      name: json['name'],
      imageUrl: json['image_url'],
      description: json['description'],
      feature: json['features'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
    );
  }
}

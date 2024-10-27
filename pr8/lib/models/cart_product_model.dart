class CartProduct {
  final int id;
  int quantity;
  // Новое поле для изображения

  CartProduct({
    required this.id,
    required this.quantity, // Новое поле для изображения
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['ID'],
      quantity: json['Quantity'],
      // Предполагаем, что API возвращает это поле
    );
  }
}

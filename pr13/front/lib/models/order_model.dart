import 'package:front/models/cart_model.dart';
import 'package:front/models/product_model.dart';

class Order {
  final int id;
  final int userId;
  final double total;
  final String status;
  final List<Product> products;

  Order({
    required this.id,
    required this.userId,
    required this.total,
    required this.status,
    required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List;
    List<Product> productsList =
        productList.map((i) => Product.fromJson(i)).toList();

    return Order(
      id: json['order_id'],
      userId: json['user_id'],
      total: (json['total'] as num).toDouble(), // Преобразование здесь
      status: json['status'],
      products: productsList,
    );
  }
}

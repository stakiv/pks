import 'package:dio/dio.dart';
import 'product_model.dart';
import 'cart_product_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('http://192.168.2.159:8080/products');
      if (response.statusCode == 200) {
        List<Product> products = (response.data as List)
            .map((product) => Product.fromJson(product))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final response = await _dio.get('http://192.168.2.159:8080/products/$id');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }

/*
  Future<Product> createProduct(Product product) async {
    try {
      final response = await _dio.post(
          'http://your-machine-ip:8080/products/create',
          data: product.toJson());
      if (response.statusCode == 201) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to create product');
      }
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }*/
  Future<void> deleteProduct(int id) async {
    try {
      final response =
          await _dio.delete('http://192.168.2.159:8080/products/delete/$id');
      if (response.statusCode == 204) {
        return;
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }

  Future<List<CartProduct>> getCart() async {
    try {
      final response = await _dio.get('http://192.168.2.159:8080/cart');
      if (response.statusCode == 200) {
        List<CartProduct> cartFlavors = (response.data as List)
            .map((item) =>
                CartProduct(id: item['productID'], quantity: item['quantity']))
            .toList();
        return cartFlavors;
      } else {
        throw Exception('Failed to load cart');
      }
    } catch (e) {
      throw Exception('Error fetching cart: $e');
    }
  }

  Future<void> addProductToCart(int productID, int quantity) async {
    try {
      await _dio.post('http://192.168.2.159:8080/cart/add', data: {
        'productID': productID,
        'quantity': 1,
      });
    } catch (e) {
      throw Exception('Error adding product to cart: $e');
    }
  }

  Future<void> removeProductFromCart(int productID) async {
    try {
      await _dio.delete('http://192.168.2.159:8080/cart/remove/$productID');
    } catch (e) {
      throw Exception('Error removing product from cart: $e');
    }
  }

  Future<void> updateProductQuantityInCart(int productID, int quantity) async {
    try {
      await _dio
          .put('http://192.168.2.159:8080/cart/update/$productID/$quantity');
    } catch (e) {
      throw Exception('Error updating product quantity in cart: $e');
    }
  }
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:front/models/cart_model.dart';
import 'package:front/models/favourites_model.dart';
import 'package:front/models/user_model.dart';
import 'product_model.dart';

class ApiService {
  final Dio _dio = Dio();

//получение списка продуктов
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

//получение данных продукта по id
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

//создание продукта
  Future<void> createProduct(Product product) async {
    try {
      final response =
          await _dio.post('http://192.168.2.159:8080/products/create', data: {
        'name': product.name,
        'image_url': product.imageUrl,
        'price': product.price,
        'description': product.description,
        'features': product.feature,
        'stock': product.stock,
      });
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to create product');
      }
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }

//удаление продукта по id
  Future<void> deleteProduct(int id) async {
    print("deleteProduct function called");
    try {
      final response =
          await _dio.delete('http://192.168.2.159:8080/products/$id');
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }

//изменение статуса продукта по id
  Future<void> changeProductStatus(Product product) async {
    print("changeProductStatus function called");
    try {
      final response = await _dio.put(
          'http://192.168.2.159:8080/products/update/${product.id}',
          data: {
            'image_url': product.imageUrl,
            'name': product.name,
            'description': product.description,
            'price': product.price,
            'features': product.feature,
            'stock': product.stock,
          });
      print(response.statusCode);
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to change Product Status');
      }
    } catch (e) {
      throw Exception('Error fetching change Product Status: $e');
    }
  }

// КОРЗИНА
//список корзины
  Future<List<Cart>> getCart(int userId) async {
    print("getCart function called");
    try {
      final response = await _dio.get('http://192.168.2.159:8080/cart/$userId');
      print("Response status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        List<Cart> cartProducts =
            (response.data as List).map((item) => Cart.fromJson(item)).toList();
        for (int i = 0; i < cartProducts.length; i++)
          print(cartProducts[i].name);
        return cartProducts;
      } else {
        throw Exception('Failed to load cart');
      }
    } catch (e) {
      throw Exception('Error fetching cart: $e');
    }
  }

  // Добавление товара в корзину
  Future<void> addToCart(int userId, int productId, int quantity) async {
    try {
      final response =
          await _dio.post('http://192.168.2.159:8080/cart/$userId', data: {
        'product_id': productId,
        'quantity': quantity,
      });
      if (response.statusCode != 200) {
        throw Exception('Failed to add to cart');
      }
    } catch (e) {
      throw Exception('Error adding to cart: $e');
    }
  }

  // Удаление товара из корзины
  Future<void> removeFromCart(int userId, int productId) async {
    try {
      final response = await _dio
          .delete('http://192.168.2.159:8080/cart/$userId/$productId');
      if (response.statusCode != 200) {
        throw Exception('Failed to remove from cart');
      }
    } catch (e) {
      throw Exception('Error removing from cart: $e');
    }
  }

  Future<int> getCountShopCartProducts(int userId) async {
    try {
      final response = await _dio.get('http://192.168.2.159:8080/cart/$userId');
      if (response.statusCode == 200) {
        int count = (response.data as List).toList().length;

        return count;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

// ИЗБРАННОЕ
//список избранного
  Future<List<Favourites>> getFavorites(int userId) async {
    try {
      final response =
          await _dio.get('http://192.168.2.159:8080/favourites/$userId');
      if (response.statusCode == 200) {
        if (response.data != null) {
          List<Favourites> products = (response.data as List)
              .map((product) => Favourites.fromJson(product))
              .toList();
          for (int i = 0; i < products.length; i++) print(products[i].name);
          return products;
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load favorites');
      }
    } catch (e) {
      throw Exception('Error fetching favorites: $e');
    }
  }

  // Добавление продукта в избранное
  Future<void> addToFavorites(int userId, int productId) async {
    try {
      final response = await _dio
          .post('http://192.168.2.159:8080/favourites/$userId', data: {
        'product_id': productId,
      });
      if (response.statusCode != 200) {
        throw Exception('Failed to add to favorites');
      }
    } catch (e) {
      throw Exception('Error adding to favorites: $e');
    }
  }

  // Удаление продукта из избранного
  Future<void> removeFromFavorites(int userId, int productId) async {
    try {
      final response = await _dio
          .delete('http://192.168.2.159:8080/favourites/$userId/$productId');
      if (response.statusCode != 200) {
        throw Exception('Failed to remove from favorites');
      }
    } catch (e) {
      throw Exception('Error removing from favorites: $e');
    }
  }

// ПОЛЬЗОВАТЕЛЬ
//найти пользователя по id
  Future<User> getUserById(int id) async {
    try {
      final response =
          await _dio.get('http://192.168.2.159:8080/users/${id.toString()}');
      if (response.statusCode == 200) {
        User data = User.fromJson(response.data);
        print(data);
        return data;
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }

//обновить данные пользователя по id
  Future<void> updateUser(User user) async {
    try {
      final response = await _dio
          .put('http://192.168.2.159:8080/users/update/${user.id}', data: {
        'name': user.name,
        'image': user.image,
        'phone': user.phoneNumber,
        'mail': user.email,
      });
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to update User');
      }
    } catch (e) {
      throw Exception('Error fetching update User: $e');
    }
  }
}

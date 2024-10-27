import 'package:flutter/material.dart';
import 'package:pr8/components/cart_item.dart';
import 'package:pr8/models/cartFlavor.dart';
import 'package:pr8/models/cart_product_model.dart';
//import 'package:pr8/models/info.dart' as info;
import 'package:pr8/models/flavor.dart';
import 'package:pr8/models/api_service.dart';
import 'package:pr8/models/product_model.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({
    super.key,
    required this.onDelete,
    required this.navToItemPage,
    required this.updtotalSum,
    required this.price,
  });
  final Function(Flavor) onDelete;
  final Function(int i) navToItemPage;
  final Function() updtotalSum;
  final int price;
  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  late Future<List<CartProduct>> _cartProducts;
  late Future<List<Product>> _products;
  double _totalSum = 0;

  @override
  void initState() {
    super.initState();
    //_loadCart();
    //_loadProducts();
    _cartProducts = ApiService().getCart();
  }
/*
  Future<void> _loadCart() async {
    try {
      _cartProducts = await ApiService().getCart();
      _calculateTotalSum();
      setState(() {});
    } catch (e) {
      print('Error loading cart: $e');
    }
  }

  Future<void> _loadProducts() async {
    try {
      _products = await ApiService().getProducts();
      setState(() {});
    } catch (e) {
      print('Error loading products: $e');
    }
  }

  void _deleteFromCart(int productID) async {
    await ApiService().removeProductFromCart(
      productID,
    );
    await _loadCart();
  }

  // сумма корзины
  void _calculateTotalSum() {
    _totalSum = _cartProducts.fold(
        0.0,
        (sum, el) =>
            sum +
            el.quantity *
                _products.firstWhere((item) => item.id == el.id).price);
  }*/
/*
  void wasDismissed(int id) {
    setState(() {
      final cartItemIndex = info.cartFlavors.indexWhere((el) => el.id == id);

      totalSum = info.cartFlavors.fold(
        0,
        (sum, el) =>
            sum +
            el.number *
                info.flavors.firstWhere((item) => item.id == el.id).price,
      );
    });
  }*/
/*
  void _addToFavorites(int i) {
    setState(() {
      if (info.favouriteFlavors.contains(i)) {
        info.favouriteFlavors.remove(i);
      } else {
        info.favouriteFlavors.add(i);
      }
    });
  }

  Future<void> _updateQuantity(int productID, int quantity) async {
    try {
      await ApiService().updateProductQuantityInCart(productID, quantity);
      await _loadCart();
    } catch (e) {
      print('Error updating product quantity: $e');
    }
  }
*/
/*
  // увеличение кол ва пациентов
  void plusPeople(int id) async {
    final cartItemIndex = _cartProducts.indexWhere((el) => el.id == id);
    if (cartItemIndex != -1) {
      _cartProducts[cartItemIndex].quantity += 1;
      await _updateQuantity(id, _cartProducts[cartItemIndex].quantity);
    }
  }

  // уменьшение кол ва пациентов
  void minusPeople(int id) async {
    final cartItemIndex = _cartProducts.indexWhere((el) => el.id == id);
    if (cartItemIndex != -1 && _cartProducts[cartItemIndex].quantity > 1) {
      _cartProducts[cartItemIndex].quantity -= 1;
      await _updateQuantity(id, _cartProducts[cartItemIndex].quantity);
    }
  }
*/
  Future<bool?> _showConfirmedDialog(
      BuildContext context, String title, Product flavor) {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(
                  flavor.imageUrl,
                  width: 150,
                  height: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Ошибка загрузки изображения');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(flavor.name),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  "Отмена",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(160, 149, 108, 1),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  "Удалить",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(118, 103, 49, 1),
                  ),
                ),
              ),
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: FutureBuilder<List<CartProduct>>(
            future: _cartProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Ошибка: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('В корзине ничего нет'));
              }

              final items = snapshot.data!;
          return Stack(
              children: [
                ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 6,
                  ),
                  
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    int flavorId =
                        items[index].id; //каждый id из списка cart
                    Product flavorM = _products.firstWhere((f) =>
                        f.id == flavorId); //элемент из общего списка по id

                    return Dismissible(
                      key: Key(flavorM.id.toString()),
                      background: Container(
                        color: const Color.fromRGBO(247, 163, 114, 1),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Icon(Icons.delete),
                      ),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        final confirmed = await _showConfirmedDialog(
                            context, flavorM.name, flavorM);
                        return confirmed ?? false;
                      },
                      onDismissed: (direction) {
                        //_deleteFromCart(_cartProducts[index].id);
                        //wasDismissed(flavorId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('${flavorM.name} удален из корзины')),
                        );
                        //_calculateTotalSum();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CartItem(
                          flavor: flavorM,
                          NavToItemPage: (int i) => {widget.navToItemPage(i)},
                          onDelete: (flavor) => widget.onDelete(flavor),
                          updateQuantity: (int id, int num) =>
                             // _updateQuantity(id, num),

                          
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.amber,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 60.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: Text(
                              '${_totalSum} ₽     оплатить',
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            );}
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/product_model.dart';
import 'package:front/pages/itam_page.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({
    super.key,
  });

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  late Future<List<Product>> _cartProducts;
  late List<Product> _cartProductsUpd;

  @override
  void initState() {
    super.initState();
    //_loadCart();
    //_loadProducts();
    _cartProducts = ApiService().getCart();
    ApiService().getCart().then(
          (i) => {_cartProductsUpd = i},
        );
  }

  void _setUpd() {
    setState(() {
      _cartProducts = ApiService().getCart();
      ApiService().getCart().then(
            (value) => {_cartProductsUpd = value},
          );
    });
  }

  void _openItem(int id) async {
    final product = await ApiService().getProductById(id);
    int? answer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItamPage(
          flavor: product,
        ),
      ),
    );
    _setUpd();
  }

  void plus(Product item) {
    Product el = Product(
        id: item.id,
        name: item.name,
        imageUrl: item.imageUrl,
        price: item.price,
        description: item.description,
        feature: item.feature,
        isFavourite: item.isFavourite,
        isInCart: item.isInCart,
        quantity: item.quantity + 1);
    ApiService().changeProductStatus(el);
    setState(() {
      _cartProductsUpd
          .elementAt(_cartProductsUpd.indexWhere((i) => i.id == item.id))
          .quantity += 1;
    });
    _setUpd();
  }

  void minus(Product item) {
    final count = item.quantity;
    Product el;
    if (count > 1) {
      el = Product(
          id: item.id,
          name: item.name,
          imageUrl: item.imageUrl,
          price: item.price,
          description: item.description,
          feature: item.feature,
          isFavourite: item.isFavourite,
          isInCart: item.isInCart,
          quantity: item.quantity - 1);
      ApiService().changeProductStatus(el);
    }
    setState(() {
      if (count > 1) {
        _cartProductsUpd
            .elementAt(_cartProductsUpd.indexWhere((i) => i.id == item.id))
            .quantity -= 1;
      }
    });
    _setUpd();
  }

  Future<bool?> _showConfirmedDialog(BuildContext context, Product flavor) {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                'Удалить из корзины?',
                style: TextStyle(fontSize: 18.0),
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
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  "Отмена",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(160, 149, 108, 1),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
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
        appBar: AppBar(
          title: const Text(
            "Корзина",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: const Color.fromRGBO(255, 248, 225, 1),
        ),
        backgroundColor: Colors.amber[50],
        body: FutureBuilder<List<Product>>(
            future: _cartProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Ошибка: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('В корзине ничего нет'));
              }

              final cartItems = snapshot.data!;

              return Stack(
                children: [
                  ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 6,
                          ),
                      itemCount: cartItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        final flavor =
                            cartItems[index]; //каждый id из списка cart
                        return Dismissible(
                            key: Key(flavor.id.toString()),
                            background: Container(
                              color: const Color.fromRGBO(247, 163, 114, 1),
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Icon(Icons.delete),
                            ),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              final confirmed =
                                  await _showConfirmedDialog(context, flavor);

                              return confirmed ?? false;
                            },
                            onDismissed: (direction) {
                              _setUpd();

                              setState(() {
                                _cartProductsUpd.removeAt(
                                    _cartProductsUpd.indexWhere((i) =>
                                        i.id == cartItems.elementAt(index).id));
                              });
                              _setUpd();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        '${flavor.name} удален из корзины')),
                              );
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                    onTap: () => {_openItem(flavor.id)},
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      padding: const EdgeInsets.all(10),
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Image.network(
                                                flavor.imageUrl,
                                                width: 120,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(
                                                width: 20.0,
                                              ),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        flavor.name,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        flavor.description,
                                                        maxLines: 2,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    65,
                                                                    65,
                                                                    65)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Цена: ${(flavor.price * flavor.quantity).toString()} ₽",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Color.fromARGB(
                                                        255, 65, 65, 65),
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              IconButton(
                                                  onPressed: () => {
                                                        minus(_cartProductsUpd
                                                            .elementAt(index))
                                                      },
                                                  icon:
                                                      const Icon(Icons.remove)),
                                              Text(_cartProductsUpd
                                                  .elementAt(index)
                                                  .quantity
                                                  .toString()),
                                              IconButton(
                                                  onPressed: () => {
                                                        plus(_cartProductsUpd
                                                            .elementAt(index))
                                                      },
                                                  icon: const Icon(Icons.add)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))));
                      }),
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
                                '${cartItems.fold(0.0, (sum, item) => sum + item.quantity * item.price)} ₽     оплатить',
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
              );
            }));
  }
}

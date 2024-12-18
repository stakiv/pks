import 'package:flutter/material.dart';
import 'package:front/pages/add_item_page.dart';
import 'package:front/pages/itam_page.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/product_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Product>> _products;
  late List<Product> _productsUpd;

  @override
  void initState() {
    super.initState();
    _products = ApiService().getProducts();
    ApiService().getProducts().then(
          (el) => {_productsUpd = el},
        );
  }

  void _setUpd() {
    setState(() {
      _products = ApiService().getProducts();
      ApiService().getProducts().then(
            (el) => {_productsUpd = el},
          );
    });
  }

  void _navigateToAddFlavorScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddFlavorScreen()),
    );
    _setUpd();
  }

  void _addToFavorites(Product i) {
    Product el = Product(
        id: i.id,
        name: i.name,
        imageUrl: i.imageUrl,
        price: i.price,
        description: i.description,
        feature: i.feature,
        isFavourite: !i.isFavourite,
        isInCart: i.isInCart,
        quantity: i.quantity);
    ApiService().changeProductStatus(el);
    setState(() {
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .isFavourite = !i.isFavourite;
    });
    _setUpd();
  }

  void addTOCart(Product i) async {
    int num;
    if (i.isInCart) {
      num = 0;
    } else {
      num = 1;
    }
    Product el = Product(
        id: i.id,
        name: i.name,
        imageUrl: i.imageUrl,
        price: i.price,
        description: i.description,
        feature: i.feature,
        isFavourite: i.isFavourite,
        isInCart: !i.isInCart,
        quantity: num);
    ApiService().changeProductStatus(el);
    setState(() {
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .isInCart = true;
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .quantity = 1;
    });
    _setUpd();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: const Text(
          "Вкусы мороженого",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 248, 225, 1),
      ),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Вкусы не добавлены'));
          }

          final items = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.61,
              //crossAxisSpacing: 10.0,
              //mainAxisSpacing: 15.0
            ),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final flavor = items[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => {_openItem(flavor.id)},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    child: Column(
                      children: [
                        Image.network(
                          flavor.imageUrl,
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                flavor.name,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                flavor.description,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 65, 65, 65)),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "Цена: ${flavor.price.toString()}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 65, 65, 65),
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                _addToFavorites(flavor);
                              },
                              icon: flavor.isFavourite
                                  ? const Icon(Icons.favorite,
                                      color: Color.fromRGBO(160, 149, 108, 1))
                                  : const Icon(Icons.favorite_border,
                                      color: Color.fromRGBO(160, 149, 108, 1)),
                            ),
                            const SizedBox(width: 20.0),
                            IconButton(
                              onPressed: () {
                                addTOCart(flavor);
                              },
                              icon: flavor.isInCart
                                  ? const Icon(Icons.shopping_cart,
                                      color: Color.fromRGBO(160, 149, 108, 1))
                                  : const Icon(Icons.add_shopping_cart,
                                      color: Color.fromRGBO(160, 149, 108, 1)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddFlavorScreen(context),
        tooltip: 'Добавить вкус',
        child: const Icon(Icons.add),
      ),
    );
  }
}

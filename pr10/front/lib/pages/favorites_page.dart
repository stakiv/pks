import 'package:flutter/material.dart';
import 'package:front/components/list_item.dart';
import 'package:front/pages/itam_page.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/product_model.dart';
import 'package:front/models/favourites_model.dart';
import 'package:front/models/cart_model.dart';

class MyFavouritesPage extends StatefulWidget {
  const MyFavouritesPage({super.key});

  @override
  State<MyFavouritesPage> createState() => _MyFavouritesPageState();
}

class _MyFavouritesPageState extends State<MyFavouritesPage> {
  late Future<List<Favourites>> _favProducts;
  late List<Favourites> _favProductsUpd;
  late List<Cart> cartItems = [];

  @override
  void initState() {
    super.initState();
    _favProducts = ApiService().getFavorites(1);
    ApiService().getFavorites(1).then((i) => {_favProductsUpd = i});
  }

  void _setUpd() {
    setState(() {
      _favProducts = ApiService().getFavorites(1);
      ApiService().getFavorites(1).then(
            (el) => {_favProductsUpd = el},
          );
    });
  }

  void _fetchCart() async {
    try {
      cartItems = await ApiService().getCart(1);
      setState(() {});
    } catch (e) {
      print('Error fetching cart: $e');
    }
  }

  void _addToFavorites(int i) async {
    await ApiService().addToFavorites(1, i);
    //_fetchFavorites();
    setState(() {
      /*
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .isFavourite = !i.isFavourite;*/
    });
    _setUpd();
  }

  void _deleteFromFavourites(int i) async {
    await ApiService().removeFromFavorites(1, i);
    //_fetchFavorites();
    setState(() {
      /*
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .isFavourite = !i.isFavourite;*/
    });
    _setUpd();
  }

  void _deleteFromCart(int i) async {
    await ApiService().removeFromCart(1, i);
    _fetchCart();
    setState(() {
      /*
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .isFavourite = !i.isFavourite;*/
    });
    _setUpd();
  }

  void addTOCart(int i) async {
    int quantity = 1;
    await ApiService().addToCart(1, i, quantity);
    _fetchCart();
    setState(() {
      /*
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .isInCart = true;
      _productsUpd
          .elementAt(_productsUpd.indexWhere((j) => j.id == i.id))
          .quantity = 1;*/
    });
    _setUpd();
  }

  void _openItem(id) async {
    final product = await ApiService().getProductById(id);
    int? answer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItamPage(
          flavor: product,
          //onAddToFavourites: (flavor) => {_deleteFromFavorites(flavor)},
          //onAddToCart: (flavor) => {_addToCart(flavor)},
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
            "Избранные вкусы",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: const Color.fromRGBO(255, 248, 225, 1),
        ),
        body: FutureBuilder<List<Favourites>>(
            future: _favProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Ошибка: ${snapshot.error}'));
              } else if (!snapshot.hasData ||
                  snapshot.data!.isEmpty ||
                  snapshot.data == null) {
                return const Center(child: Text('Вкусы не добавлены'));
              }

              final items = snapshot.data!;
              /*
              for (int i = 0; i < items.length; i++) {
                print(items);
              }*/
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.61,
                ),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final flavor = items[index];
                  final flId = items[index].productid;
                  print('flavor ${flavor.id}   flId ${flId}   ${flavor.name}');

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListItem(
                      key: Key(flavor.productid.toString()),
                      flavor: flavor,
                      onAddToFavourites: (int flavor) =>
                          {_addToFavorites(flavor)},
                      onDeleteFromFavourites: (int flavor) =>
                          {_deleteFromFavourites(flavor)},
                      onAddToCart: (int flavor) => {addTOCart(flavor)},
                      onDeleteFromCart: (int flavor) =>
                          {_deleteFromCart(flavor)},
                      NavToItemPage: (int i) => {_openItem(i)},
                    ),
                  );
                },
              );
            }));
  }
}

import 'package:flutter/material.dart';
import 'package:front/components/list_item.dart';
import 'package:front/pages/itam_page.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/favourites_model.dart';
import 'package:front/models/cart_model.dart';
import 'package:front/models/user_model.dart';
import 'package:front/auth/auth_service.dart';

class MyFavouritesPage extends StatefulWidget {
  const MyFavouritesPage({super.key});

  @override
  State<MyFavouritesPage> createState() => _MyFavouritesPageState();
}

class _MyFavouritesPageState extends State<MyFavouritesPage> {
  late Future<List<Favourites>>? _favProducts;
  late List<Favourites> _favProductsUpd;
  late List<Cart> cartItems = [];
  late Future<User> user;
  late int userId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    user = ApiService().getUserByEmail(AuthService().getCurrentUserEmail());
    user.then((currUser) {
      userId = currUser.id;
      _favProducts = ApiService().getFavorites(userId);
      _favProducts?.then((favProducts) {
        _favProductsUpd = favProducts;
        setState(() {
          isLoading = false;
        });
      });
    }).catchError((e) {
      print('ошибка загрузки польхователя $e');
      setState(() {
        isLoading = false;
      });
    });
  }

  void _setUpd() {
    setState(() {
      user.then((currentUser) {
        userId = currentUser.id;
        _favProducts = ApiService().getFavorites(userId);
        _favProducts?.then((cartItems) {
          _favProductsUpd = cartItems; // Инициализируем _favProductsUpd
        });
      });
    });
  }

  void _fetchCart() async {
    try {
      cartItems = await ApiService().getCart(userId);
      setState(() {});
    } catch (e) {
      print('Error fetching cart: $e');
    }
  }

  void _addToFavorites(int i) async {
    await ApiService().addToFavorites(userId, i);
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
    await ApiService().removeFromFavorites(userId, i);
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
    await ApiService().removeFromCart(userId, i);
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
    await ApiService().addToCart(userId, i, quantity);
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
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
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
        body: _favProducts == null
            ? Center(
                child: Text('В избранном ничего нет'),
              )
            : FutureBuilder<List<Favourites>>(
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.61,
                    ),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final flavor = items[index];
                      final flId = items[index].productid;
                      print(
                          'flavor ${flavor.id}   flId ${flId}   ${flavor.name}');

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

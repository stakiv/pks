import 'package:flutter/material.dart';
import 'package:pr8/components/list_item.dart';
import 'package:pr8/models/flavor.dart';
import 'package:pr8/models/info.dart' as info;
import 'package:pr8/pages/itam_page.dart';
import 'package:pr8/models/cartFlavor.dart';
import 'package:pr8/models/api_service.dart';
import 'package:pr8/models/product_model.dart';

class MyFavouritesPage extends StatefulWidget {
  const MyFavouritesPage({super.key});

  @override
  State<MyFavouritesPage> createState() => _MyFavouritesPageState();
}

class _MyFavouritesPageState extends State<MyFavouritesPage> {
  late Future<List<Product>> _products;
  @override
  void initState() {
    super.initState();
    _products = ApiService().getProducts();
  }

  void _deleteFromFavorites(int flavorId) async {
    setState(() {
      info.favouriteFlavors.removeWhere((element) => element == flavorId);
    });
  }

  void _addToCart(Product flavor) async {
    setState(() {
      if (info.cartFlavors.any((flavorId) => flavorId.id == flavor.id)) {
        info.cartFlavors.removeWhere((flavorId) => flavorId.id == flavor.id);
      } else {
        CartFlavor cartFl = CartFlavor(flavor.id, 1);
        info.cartFlavors.add(cartFl);
        //print('добавлен в корзину на избарнном  ${flavor.flavorName}');
      }
    });
  }
/*
  void _addToFavorites(Flavor flavor) async {
    setState(() {
      if (info.favouriteFlavors.contains(flavor.id)) {
        info.favouriteFlavors.remove(flavor.id);
      } else {
        info.favouriteFlavors.add(flavor.id);
      }
    });
  }*/

  int findIndexById(int id) {
    return info.flavors.indexWhere((item) => item.id == id);
  }

  void deleteItem(int flavorid, BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 255, 246, 218),
        title: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: const Padding(
            padding: EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
            child: Center(
              child: Text(
                'Удалить карточку товара?',
                style: TextStyle(fontSize: 16.00, color: Colors.black),
              ),
            ),
          ),
        ),
        content: const Padding(
          padding: EdgeInsets.only(right: 8.0, left: 8.0),
          child: Text(
            'После удаления востановить товар будет невозможно',
            style: TextStyle(fontSize: 14.00, color: Colors.black),
            softWrap: true,
            textAlign: TextAlign.justify,
            textDirection: TextDirection.ltr,
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[700]),
            child: const Text('Ок',
                style: TextStyle(color: Colors.black, fontSize: 14.0)),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          TextButton(
            child: const Text('Отмена',
                style: TextStyle(color: Colors.black, fontSize: 14.0)),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    ).then((bool? isDeleted) {
      if (isDeleted != null && isDeleted) {
        setState(() {
          if (info.cartFlavors.any((el) => el.id == flavorid)) {
            info.cartFlavors.removeWhere((el) => el.id == flavorid);
          }

          info.favouriteFlavors.remove(flavorid);

          Navigator.pop(context, findIndexById(flavorid));
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${info.flavors.firstWhere((flavor) => flavor.id == flavorid).flavorName} удален',
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 16.0),
            ),
            backgroundColor: Color.fromRGBO(60, 60, 60, 1),
          ),
        );
      }
    });
  }

  void _openItem(id) async {
    final product = await ApiService().getProductById(id);
    int? answer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItamPage(
          flavor: product,
          onAddToFavourites: (flavor) => {_deleteFromFavorites(flavor)},
          onAddToCart: (flavor) => {_addToCart(flavor)},
        ),
      ),
    );
    setState(() {
      if (answer != null) {
        info.flavors.remove(info.flavors
            .elementAt(info.flavors.indexWhere((el) => el.id == id)));
        info.favouriteFlavors.removeWhere((id) =>
            id ==
            info.flavors
                .elementAt(info.flavors.indexWhere((el) => el.id == id))
                .id);
        info.cartFlavors.removeWhere((flId) =>
            flId.id ==
            info.flavors
                .elementAt(info.flavors.indexWhere((el) => el.id == id))
                .id);
      }
    });
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
        body: FutureBuilder<List<Product>>(
            future: _products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Ошибка: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('Вкусы не добавлены'));
              }

              final items = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.61,
                ),
                itemCount: info.favouriteFlavors.length,
                itemBuilder: (BuildContext context, int index) {
                  final flavor = items[index];
                  int flavorId = info
                      .favouriteFlavors[index]; //каждый id из списка favourite
                  Flavor flavorM = info.flavors.firstWhere(
                      (f) => f.id == flavorId); //вкус из общего списка по id

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListItem(
                      key: Key(flavorM.id.toString()),
                      flavor: flavor,
                      //onDelete: (flavor) => deleteItem(flavor.id, context),
                      onAddToFavourites: (flavor) =>
                          {_deleteFromFavorites(flavor.id)},
                      onAddToCart: (flavor) => {_addToCart(flavor)},
                      NavToItemPage: (int i) => {_openItem(i)},
                    ),
                  );
                },
              );
            }));
  }
}

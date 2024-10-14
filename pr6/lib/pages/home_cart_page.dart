import 'package:flutter/material.dart';
import 'package:pr6/components/cart_item.dart';
import 'package:pr6/models/cartFlavor.dart';
import 'package:pr6/models/info.dart' as info;
import 'package:pr6/models/flavor.dart';
import 'package:pr6/pages/itam_page.dart';
import 'package:pr6/pages/cart_page.dart';

class MyHomeCartPage extends StatefulWidget {
  const MyHomeCartPage({super.key});

  @override
  State<MyHomeCartPage> createState() => _MyHomeCartPageState();
}

class _MyHomeCartPageState extends State<MyHomeCartPage> {
  /*
  void _addToCart(Flavor flavor) async {
    setState(() {
      if (info.cartFlavors.any((flavorId) => flavorId.id == flavor.id)) {
        info.cartFlavors.removeWhere((flavorId) => flavorId.id == flavor.id);
        //print('удален из корзины на корзине ${flavor.flavorName}');
      } else {
        Cartflavor cartFl = Cartflavor(flavor.id, 1);
        info.cartFlavors.add(cartFl);
        //print('добавлен в корзину на корзине  ${flavor.flavorName}');
      }
    });
  }*/

  void _addToFavorites(Flavor flavor) async {
    setState(() {
      if (info.favouriteFlavors.contains(flavor.id)) {
        info.favouriteFlavors.remove(flavor.id);
      } else {
        info.favouriteFlavors.add(flavor.id);
      }
    });
  }

  void _deleteFromCart(CartFlavor cartFlavor) async {
    setState(() {
      info.cartFlavors.removeWhere((el) => el.id == cartFlavor.id);
    });
  }

  /*
  void _removeFlavor(Flavor flavor) async {
    bool? confirmed =
        await _showConfirmedDialog(context, 'Удалить элемент?', flavor);
    if (confirmed == true) {
      setState(() {
        info.flavors.remove(flavor);
        info.favouriteFlavors.removeWhere((element) => element == flavor.id);
        info.cartFlavors.removeWhere((element) => element == flavor.id);
      });
    }
  }*/

  Future<bool?> _showConfirmedDialog(
      BuildContext context, String title, Flavor flavor) {
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
                  flavor.image,
                  width: 150,
                  height: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Ошибка загрузки изображения');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(flavor.flavorName),
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

  int findIndexById(int id) {
    return info.flavors.indexWhere((item) => item.id == id);
  }

  void deleteItem(int i, BuildContext context) {
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
          info.cartFlavors.removeWhere((cartFl) => cartFl.id == i);

          if (info.favouriteFlavors.any((el) => el == i)) {
            info.favouriteFlavors.remove(i);
          }
          Navigator.pop(context, findIndexById(i));
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${info.flavors.firstWhere((flavor) => flavor.id == i).flavorName} удален',
              style: const TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            backgroundColor: Colors.amber[700],
          ),
        );
      }
    });
  }

  void _openItem(int id) async {
    int? answer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItamPage(
          flavor: info.flavors
              .elementAt(info.flavors.indexWhere((el) => el.id == id)),
          onAddToFavourites: (flavor) => {_addToFavorites(flavor)},
          onAddToCart: (flavor) => {_deleteFromCart(flavor)},
          /*onDelete: widget.onDelete: () {
            widget.onDelete(widget.flavor);
            Navigator.pop(context);
          },*/
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

  int _getTotalPrice() {
    int totalSum = 0;
    for (var cartFlavor in info.cartFlavors) {
      Flavor flavor = info.flavors.firstWhere((fl) => fl.id == cartFlavor.id);

      totalSum += flavor.price * cartFlavor.number;
      print(totalSum);
    }
    return totalSum;
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
      body: info.cartFlavors.isEmpty
          ? const Center(
              child: Text('В корзине ничего нет'),
            )
          : Stack(
              children: [
                MyCartPage(
                  onDelete: (flavor) => deleteItem(flavor.id, context),
                  navToItemPage: (int i) => _openItem(i),
                  totalSum: _getTotalPrice(),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Стоимость ${_getTotalPrice().toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ))
              ],
            ),
    );
  }
}

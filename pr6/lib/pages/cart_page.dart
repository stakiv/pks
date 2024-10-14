import 'package:flutter/material.dart';
import 'package:pr6/components/cart_item.dart';
import 'package:pr6/models/info.dart' as info;
import 'package:pr6/models/flavor.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pr6/pages/itam_page.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  /*void _deleteFromCart(Flavor flavor) {
    setState(() {
      info.cartFlavors.remove(flavor.id);
    });
  }*/

  void _addToCart(Flavor flavor) async {
    setState(() {
      if (info.cartFlavors.contains(flavor.id)) {
        info.cartFlavors.remove(flavor.id);
        print('удален из корзины на корзине ${flavor.flavorName}');
      } else {
        info.cartFlavors.add(flavor.id);
        print('добавлен в корзину на корзине  ${flavor.flavorName}');
      }
    });
  }

  void _addToFavorites(Flavor flavor) async {
    setState(() {
      if (info.favouriteFlavors.contains(flavor.id)) {
        info.favouriteFlavors.remove(flavor.id);
      } else {
        info.favouriteFlavors.add(flavor.id);
      }
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

  void remItem(int i, BuildContext context) {
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
          if (info.cartFlavors.any((el) => el == i)) {
            info.cartFlavors.removeWhere((el) => el == i);
          }
          if (info.favouriteFlavors.any((el) => el == i)) {
            info.favouriteFlavors.remove(i);
          }
          Navigator.pop(context, findIndexById(i));
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Товар успешно удален',
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            backgroundColor: Colors.amber[700],
          ),
        );
      }
    });
  }

  void _openItem(id) async {
    print('Попал 0');
    int? answer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItamPage(
          flavor: info.flavors
              .elementAt(info.flavors.indexWhere((el) => el.id == id)),
          /*onDelete: widget.onDelete: () {
            widget.onDelete(widget.flavor);
            Navigator.pop(context);
          },*/
        ),
      ),
    );
    setState(() {
      print('Попал 1');
      if (answer != null) {
        print('Попал 2');
        info.flavors.remove(info.flavors
            .elementAt(info.flavors.indexWhere((el) => el.id == id)));
        info.favouriteFlavors.removeWhere((id) =>
            id ==
            info.flavors
                .elementAt(info.flavors.indexWhere((el) => el.id == id))
                .id);
        info.cartFlavors.removeWhere((id) =>
            id ==
            info.flavors
                .elementAt(info.flavors.indexWhere((el) => el.id == id))
                .id);
        print('Попал 3');
      }
      print('Попал 4');
    });
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
                ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 6,
                  ),
                  itemCount: info.cartFlavors.length,
                  itemBuilder: (BuildContext context, int index) {
                    int flavorId =
                        info.cartFlavors[index]; //каждый id из списка cart
                    Flavor flavorM = info.flavors.firstWhere((f) =>
                        f.id == flavorId); //элемент из общего списка по id

                    return Dismissible(
                      key: Key(flavorM.id.toString()),
                      background: Container(
                        color: Color.fromRGBO(247, 163, 114, 1),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: const Icon(Icons.delete),
                      ),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        final confirmed = await _showConfirmedDialog(
                            context, flavorM.flavorName, flavorM);
                        return confirmed ?? false;
                      },
                      onDismissed: (direction) {
                        _addToCart(flavorM);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  '${flavorM.flavorName} удален из корзины')),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CartItem(
                          flavor: flavorM,
                          NavToItemPage: (int i) => {_openItem(i)},
                          onDelete: (flavor) => remItem(flavor.id, context),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}

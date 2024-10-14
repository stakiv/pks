import 'package:flutter/material.dart';
import 'package:pr6/components/list_item.dart';
import 'package:pr6/models/flavor.dart';
import 'package:pr6/models/info.dart' as info;
import 'package:pr6/pages/itam_page.dart';

class MyFavouritesPage extends StatefulWidget {
  const MyFavouritesPage({super.key});

  @override
  State<MyFavouritesPage> createState() => _MyFavouritesPageState();
}

class _MyFavouritesPageState extends State<MyFavouritesPage> {
  /*void _removeFlavor(int index) async {
    bool? confirmed = await _showConfirmedDialog(
        context, 'Удалить элемент?', info.flavors[index]);
    if (confirmed == true) {
      setState(() {
        info.flavors.removeAt(index);
        info.favouriteFlavors.removeWhere((element) => element == index);
      });
    }
  }*/

  void _deleteFromFavorites(Flavor flavor) async {
    setState(() {
      info.favouriteFlavors.removeWhere((element) => element == flavor.id);
    });
  }

  void _addToCart(Flavor flavor) async {
    setState(() {
      if (info.favouriteFlavors.contains(flavor.id)) {
        info.favouriteFlavors.remove(flavor.id);
        print('удален из корзины на избарнном ${flavor.flavorName}');
      } else {
        info.favouriteFlavors.add(flavor.id);
        print('добавлен в корзину на избарнном  ${flavor.flavorName}');
      }
    });
  }

  void _addToFavorites(Flavor flavor) async {
    setState(() {
      if (info.favouriteFlavors.contains(flavor.id)) {
        info.favouriteFlavors.remove(flavor.id);
        print('удален из избранного на главном ${flavor.flavorName}');
      } else {
        info.favouriteFlavors.add(flavor.id);
        print('добавлен в избранное на главном ${flavor.flavorName}');
      }
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
      body: info.favouriteFlavors.isEmpty
          ? const Center(
              child: Text('Нет избарнных вкусов'),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.61,
              ),
              itemCount: info.favouriteFlavors.length,
              itemBuilder: (BuildContext context, int index) {
                int flavorId = info
                    .favouriteFlavors[index]; //каждый id из списка favourite
                Flavor flavorM = info.flavors.firstWhere(
                    (f) => f.id == flavorId); //вкус из общего списка по id

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListItem(
                    flavor: flavorM,
                    onDelete: (flavor) => remItem(flavor.id, context),
                    onAddToFavourites: (flavor) =>
                        {_deleteFromFavorites(flavor)},
                    onAddToCart: (flavor) => {_addToCart(flavor)},
                    NavToItemPage: (int i) => {_openItem(i)},
                  ),
                );
              },
            ),
    );
  }
}

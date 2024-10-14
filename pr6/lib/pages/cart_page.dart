import 'package:flutter/material.dart';
import 'package:pr6/components/cart_item.dart';
import 'package:pr6/models/cartFlavor.dart';
import 'package:pr6/models/info.dart' as info;
import 'package:pr6/models/flavor.dart';
import 'package:pr6/pages/itam_page.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({
    super.key,
    required this.onDelete,
    required this.navToItemPage,
    required this.totalSum,
  });
  final Function(Flavor) onDelete;
  final Function(int i) navToItemPage;
  final int totalSum;
  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
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
                        info.cartFlavors[index].id; //каждый id из списка cart
                    Flavor flavorM = info.flavors.firstWhere((f) =>
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
                            context, flavorM.flavorName, flavorM);
                        return confirmed ?? false;
                      },
                      onDismissed: (direction) {
                        _deleteFromCart(info.cartFlavors[index]);
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
                          NavToItemPage: (int i) => {widget.navToItemPage(i)},
                          onDelete: (flavor) => widget.onDelete(flavor),
                          totalSum: widget.totalSum,
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

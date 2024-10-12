import 'package:flutter/material.dart';
import 'package:pr6/components/cart_item.dart';
import 'package:pr6/models/info.dart' as info;
import 'package:pr6/models/flavor.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  void _deleteFromCart(int index) {
    setState(() {
      info.cartFlavors.removeAt(index);
    });
  }

  Future<bool?> _showConfirmedDialog(
      BuildContext context, String flavorName, String image) {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                'Удалить из корзины',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(
                  image,
                  width: 150,
                  height: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Ошибка загрузки изображения');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(flavorName),
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
                    int flavorIndex = info.cartFlavors[index];
                    var flavor = info.flavors[flavorIndex];

                    return Dismissible(
                      key: Key(index.toString()),
                      background: Container(
                        color: Color.fromRGBO(247, 163, 114, 1),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: const Icon(Icons.delete),
                      ),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        final confirmed = await _showConfirmedDialog(
                            context, flavor.flavorName, flavor.image);
                        return confirmed ?? false;
                      },
                      onDismissed: (direction) {
                        _deleteFromCart(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  '${flavor.flavorName} удален из корзины')),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CartItem(
                          flavor: flavor,
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

import 'package:flutter/material.dart';
import 'package:pr6/components/cart_item.dart';
import 'package:pr6/models/cartFlavor.dart';
import 'package:pr6/models/info.dart' as info;
import 'package:pr6/models/flavor.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({
    super.key,
    required this.onDelete,
    required this.navToItemPage,
    required this.updtotalSum,
    required this.price,
  });
  final Function(Flavor) onDelete;
  final Function(int i) navToItemPage;
  final Function() updtotalSum;
  final int price;
  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  List<Flavor> cartItemsList = info.flavors
      .where((el) => info.cartFlavors.any((i) => i.id == el.id))
      .toList();

  // сумма корзины
  int totalSum = info.cartFlavors.fold(
      0,
      (sum, el) =>
          sum +
          el.number * info.flavors.firstWhere((i) => i.id == el.id).price);

  // увеличение кол ва пациентов
  void plusPeople(int id) {
    setState(() {
      final cartItemIndex = info.cartFlavors.indexWhere((el) => el.id == id);
      if (cartItemIndex != -1) {
        info.cartFlavors[cartItemIndex].number += 1;

        totalSum = info.cartFlavors.fold(
          0,
          (sum, el) =>
              sum +
              el.number *
                  info.flavors.firstWhere((item) => item.id == el.id).price,
        );
      }
    });
  }

  // уменьшение кол ва пациентов
  void minusPeople(int id) {
    setState(() {
      final cartItemIndex = info.cartFlavors.indexWhere((el) => el.id == id);

      if (cartItemIndex != -1 && info.cartFlavors[cartItemIndex].number > 1) {
        info.cartFlavors[cartItemIndex].number -= 1;
        totalSum = info.cartFlavors.fold(
          0,
          (sum, el) =>
              sum +
              el.number *
                  info.flavors.firstWhere((item) => item.id == el.id).price,
        );
      }
    });
  }

  void wasDismissed(int id) {
    setState(() {
      final cartItemIndex = info.cartFlavors.indexWhere((el) => el.id == id);

      totalSum = info.cartFlavors.fold(
        0,
        (sum, el) =>
            sum +
            el.number *
                info.flavors.firstWhere((item) => item.id == el.id).price,
      );
    });
  }

  void _addToFavorites(int i) {
    setState(() {
      if (info.favouriteFlavors.contains(i)) {
        info.favouriteFlavors.remove(i);
      } else {
        info.favouriteFlavors.add(i);
      }
    });
  }

  void _deleteFromCart(CartFlavor cartFlavor) async {
    setState(() {
      info.cartFlavors.removeWhere((el) => el.id == cartFlavor.id);
    });
  }

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
                        wasDismissed(flavorId);
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
                          minusPeople: (int num) => minusPeople(num),

                          plusPeople: (int num) => plusPeople(num),
                          //price: widget.price,
                        ),
                      ),
                    );
                  },
                ),
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
                              '${totalSum} ₽     оплатить',
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
            ),
    );
  }
}

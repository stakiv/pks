import 'package:flutter/material.dart';
import 'package:pr6/models/flavor.dart';
import 'package:pr6/pages/itam_page.dart';
import 'package:pr6/models/info.dart' as info;

class CartItem extends StatefulWidget {
  const CartItem(
      {super.key,
      required this.flavor,
      required this.onDelete,
      required this.NavToItemPage
      //required this.onDelete,
      //required this.onAddToCart,
      //required this.onDelete,
      });
  final Function(Flavor) onDelete;
  final Flavor flavor;
  final Function(int i) NavToItemPage;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int _num = 1;
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
          /*child: Text(
            'После удаления востановить товар будет невозможно',
            style: TextStyle(fontSize: 14.00, color: Colors.black),
            softWrap: true,
            textAlign: TextAlign.justify,
            textDirection: TextDirection.ltr,
          ),*/
        ),
        actions: [
          TextButton(
            child: const Text('Отмена',
                style: TextStyle(color: Colors.black, fontSize: 14.0)),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          TextButton(
            //style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[700]),
            child: const Text('Удалить',
                style: TextStyle(color: Colors.black, fontSize: 14.0)),
            onPressed: () {
              Navigator.pop(context, true);
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

  @override
  Widget build(BuildContext context) {
    void _plusNum() {
      setState(() {
        _num++;
      });
    }

    void _minusNum() {
      if (_num > 1) {
        setState(() {
          _num--;
        });
      }
    }

    return GestureDetector(
      onTap: () => {widget.NavToItemPage(widget.flavor.id)},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                  widget.flavor.image,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          widget.flavor.flavorName,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          widget.flavor.description,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 65, 65, 65)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Цена: ${(widget.flavor.price * _num).toString()}",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 65, 65, 65),
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: _minusNum, icon: const Icon(Icons.remove)),
                Text(_num.toString()),
                IconButton(onPressed: _plusNum, icon: const Icon(Icons.add)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

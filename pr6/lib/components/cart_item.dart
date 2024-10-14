import 'package:flutter/material.dart';
import 'package:pr6/models/cartFlavor.dart';
import 'package:pr6/models/flavor.dart';
import 'package:pr6/models/info.dart' as info;

class CartItem extends StatefulWidget {
  const CartItem(
      {super.key,
      required this.flavor,
      required this.onDelete,
      required this.NavToItemPage,
      required this.totalSum
      //required this.onDelete,
      //required this.onAddToCart,
      //required this.onDelete,
      });
  final Function(Flavor) onDelete;
  final Flavor flavor;
  final Function(int i) NavToItemPage;
  final int totalSum;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int _num = 1;
  int findIndexById(int id) {
    return info.flavors.indexWhere((item) => item.id == id);
  }

  @override
  void initState() {
    super.initState();
    _num =
        info.cartFlavors.firstWhere((fl) => fl.id == widget.flavor.id).number;
  }

  void _updateCart() {
    final index =
        info.cartFlavors.indexWhere((el) => el.id == widget.flavor.id);
    if (index != -1) {
      info.cartFlavors[index].number = _num;
      print(info.cartFlavors[index].number);
    }
  }

  void _plusNum() {
    setState(() {
      _num++;
      _updateCart();
      print('ПРИБАВЛЕНИЕ');
    });
  }

  void _minusNum() {
    if (_num > 1) {
      setState(() {
        _num--;
        _updateCart();
        print('УБАВЛЕНИЕ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

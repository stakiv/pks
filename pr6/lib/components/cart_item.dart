import 'package:flutter/material.dart';
import 'package:pr6/models/flavor.dart';
import 'package:pr6/models/info.dart' as info;

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.flavor,
    required this.onDelete,
    required this.NavToItemPage,
    required this.plusPeople,
    required this.minusPeople,
  });
  final Function(Flavor) onDelete;
  final Flavor flavor;
  final Function(int i) NavToItemPage;
  final Function(int num) plusPeople;
  final Function(int num) minusPeople;

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

/*
  void _updateCart() {
    final index =
        info.cartFlavors.indexWhere((el) => el.id == widget.flavor.id);
    if (index != -1) {
      info.cartFlavors[index].number = _num;
      widget.updtotalSum();
      print(info.cartFlavors[index].number);
      print('widget.totalSum ${widget.updtotalSum()}');
    }
  }

  void _plusNum() {
    setState(() {
      _num++;
      _updateCart();
      widget.updtotalSum();
      print('сумма ${widget.price}');
      print('ПРИБАВЛЕНИЕ');
    });
  }

  void _minusNum() {
    if (_num > 1) {
      setState(() {
        _num--;
        _updateCart();
        widget.updtotalSum();
        print('сумма ${widget.updtotalSum()}');
        print('УБАВЛЕНИЕ');
      });
    }
  }*/
/*
  int _getTotalPrice() {
    int totalSum = 0;
    for (var cartFlavor in info.cartFlavors) {
      Flavor flavor = info.flavors.firstWhere((fl) => fl.id == cartFlavor.id);

      totalSum += flavor.price * cartFlavor.number;
      print(totalSum);
    }
    setState(() {
      totalSum;
      print('итоговая сумма ${totalSum}');
    });
    return totalSum;
  }*/

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
                  "Цена: ${(widget.flavor.price * info.cartFlavors.firstWhere((el) => el.id == widget.flavor.id).number).toString()} ₽",
                  style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 65, 65, 65),
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 20,
                ),
                IconButton(
                    onPressed: () => {widget.minusPeople(widget.flavor.id)},
                    icon: const Icon(Icons.remove)),
                Text(
                    '${info.cartFlavors.firstWhere((el) => el.id == widget.flavor.id).number}'),
                IconButton(
                    onPressed: () => {widget.plusPeople(widget.flavor.id)},
                    icon: const Icon(Icons.add)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

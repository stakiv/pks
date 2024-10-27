import 'package:flutter/material.dart';
import 'package:pr8/models/flavor.dart';
import 'package:pr8/models/info.dart' as info;
import 'package:pr8/models/product_model.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.flavor,
    required this.onDelete,
    required this.NavToItemPage,
    required this.updateQuantity,
  });
  final Function(Flavor) onDelete;
  final Product flavor;
  final Function(int i) NavToItemPage;
  final Function(int id, int num) updateQuantity;

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
                  widget.flavor.imageUrl,
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
                          widget.flavor.name,
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
                    onPressed: () =>
                        {widget.updateQuantity(widget.flavor.id, 1)},
                    icon: const Icon(Icons.remove)),
                Text(
                    '${info.cartFlavors.firstWhere((el) => el.id == widget.flavor.id).number}'),
                IconButton(
                    onPressed: () =>
                        {widget.updateQuantity(widget.flavor.id, -1)},
                    icon: const Icon(Icons.add)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

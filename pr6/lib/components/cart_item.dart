import 'package:flutter/material.dart';
import 'package:pr6/models/flavor.dart';
import 'package:pr6/pages/itam_page.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.flavor,
    //required this.onAddToCart,
    //required this.onDelete,
  });
  final Flavor flavor;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int _num = 1;
  //final Function(Flavor) onAddToCart;
  //final Function(Flavor) onDelete;
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
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItamPage(
            flavor: widget.flavor,
            /*index: widget.flavor.id,
            flavorName: widget.flavor.flavorName,
            image: widget.flavor.image,
            description: widget.flavor.description,
            price: widget.flavor.price,
            feature: widget.flavor.feature,*/
          ),
        ),
      ),
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
            SizedBox(
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
                SizedBox(
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pr7/models/info.dart';
import 'package:pr7/models/cart.dart';
import 'package:pr7/models/items.dart';

class CartItemListPage extends StatefulWidget {
  const CartItemListPage({
    super.key,
    required this.item,
  });

  final Item item;

  @override
  State<CartItemListPage> createState() => _CartItemListPage();
}

class _CartItemListPage extends State<CartItemListPage> {
  void AddTOCart(int i) {
    setState(() {
      if (!cartItems.any((item) => item.id == i)) {
        cartItems.add(CartItem(i, 1));
      } else {
        cartItems.removeAt(cartItems.indexWhere((item) => item.id == i));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String days;
    if (widget.item.numDays % 10 == 1) {
      days = 'день';
    } else if (widget.item.numDays % 10 == 2 ||
        widget.item.numDays % 10 == 3 ||
        widget.item.numDays % 10 == 4) {
      days = 'дня';
    } else {
      days = 'дней';
    }
    return Container(
      decoration: BoxDecoration(
        //color: const Color.fromARGB(255, 32, 134, 27),
        border: Border.all(
          width: 1,
          color: const Color.fromRGBO(224, 224, 224, 1.0),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16.0),
      width: 335,
      //height: 138,
      child: Column(
        children: [
          Text(
            widget.item.name,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(0, 0, 0, 1.0),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.item.numDays.toString()} $days',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(147, 147, 150, 1.0))),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    '${widget.item.cost.toString()} ₽',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 17, color: Color.fromRGBO(0, 0, 0, 1.0))),
                  )
                ],
              ),
              TextButton(
                onPressed: () {
                  AddTOCart(widget.item.id);
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
                  backgroundColor: const Color.fromRGBO(26, 111, 238, 1.0),
                ),
                child: Text(
                  'Добавить',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(255, 255, 255, 1.0),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

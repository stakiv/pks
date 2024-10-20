import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pr7/models/info.dart';
import 'package:pr7/models/cart.dart';

class HomeItemListPage extends StatefulWidget {
  const HomeItemListPage(
      {super.key,
      required this.id,
      required this.name,
      required this.numDays,
      required this.cost});

  final int id;
  final String name;
  final int numDays;
  final int cost;

  @override
  State<HomeItemListPage> createState() => _HomeItemListPage();
}

class _HomeItemListPage extends State<HomeItemListPage> {
  void addTOCart(int i) {
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
    if (widget.numDays % 100 > 10 && widget.numDays % 100 < 15) {
      days = 'дней';
    } else if (widget.numDays % 10 == 1) {
      days = 'день';
    } else if (widget.numDays % 10 == 2 ||
        widget.numDays % 10 == 3 ||
        widget.numDays % 10 == 4) {
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
            widget.name,
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
                    '${widget.numDays.toString()} $days',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(147, 147, 150, 1.0))),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    '${widget.cost.toString()} ₽',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 17, color: Color.fromRGBO(0, 0, 0, 1.0))),
                  )
                ],
              ),
              TextButton(
                onPressed: () {
                  addTOCart(widget.id);
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  foregroundColor: cartItems.any((el) => el.id == widget.id)
                      ? const Color.fromRGBO(147, 147, 150, 1.0)
                      : const Color.fromRGBO(255, 255, 255, 1.0),
                  backgroundColor: cartItems.any((el) => el.id == widget.id)
                      ? const Color.fromRGBO(245, 245, 249, 1.0)
                      : const Color.fromRGBO(26, 111, 238, 1.0),
                ),
                child: Text(
                  cartItems.any((el) => el.id == widget.id)
                      ? 'Удалить'
                      : 'Добавить',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      //color: Color.fromRGBO(255, 255, 255, 1.0),
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

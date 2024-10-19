import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pr7/models/info.dart';
import 'package:pr7/models/cart.dart';
import 'package:pr7/models/items.dart';

class CartItemListPage extends StatefulWidget {
  const CartItemListPage({
    super.key,
    required this.item,
    required this.people,
  });

  final Item item;
  final int people;

  @override
  State<CartItemListPage> createState() => _CartItemListPage();
}

class _CartItemListPage extends State<CartItemListPage> {
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
    String people;
    if (widget.people % 10 == 1) {
      people = 'пациент';
    } else if (widget.item.numDays % 10 == 2 ||
        widget.item.numDays % 10 == 3 ||
        widget.item.numDays % 10 == 4) {
      people = 'пациента';
    } else {
      people = 'дней';
    }
    void plusPeople(int i) {
      setState(() {
        cartItems
            .elementAt(cartItems.indexWhere((el) => el.id == i))
            .numPeople += 1;
      });
    }

    void minusPeople(int i) {
      if (cartItems.firstWhere((el) => el.id == i).numPeople > 1) {
        setState(() {
          cartItems
              .elementAt(cartItems.indexWhere((el) => el.id == i))
              .numPeople -= 1;
        });
      }
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
                    '${widget.item.cost.toString()} ₽',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 17, color: Color.fromRGBO(0, 0, 0, 1.0))),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    '${widget.people} $people',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(0, 0, 0, 1.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Container(
                    width: 31.0,
                    height: 32.0,
                    child: ElevatedButton(
                      onPressed: () {
                        minusPeople(widget.item.id);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            const Color.fromRGBO(245, 245, 249, 1.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)),
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/cart/minus.png')),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 32.0,
                    color: const Color.fromRGBO(245, 245, 249, 1.0),
                    child: Image.asset('assets/cart/Divider.png'),
                  ),
                  Container(
                    width: 31.0,
                    height: 32.0,
                    child: ElevatedButton(
                      onPressed: () {
                        plusPeople(widget.item.id);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            const Color.fromRGBO(245, 245, 249, 1.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/cart/plus.png')),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

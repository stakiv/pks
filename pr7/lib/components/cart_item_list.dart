import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pr7/models/info.dart';
import 'package:pr7/models/cart.dart';
import 'package:pr7/models/items.dart';

class CartItemListPage extends StatefulWidget {
  const CartItemListPage({
    super.key,
    required this.item,
    required this.plusPeople,
    required this.minusPeople,
    required this.deleteFromCart,
    //required this.people,
  });
  final Function(int num) plusPeople;
  final Function(int num) minusPeople;
  final Function(int num) deleteFromCart;
  final Item item;
  //final int people;

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
    if (cartItems.firstWhere((el) => el.id == widget.item.id).numPeople % 100 >
            10 &&
        cartItems.firstWhere((el) => el.id == widget.item.id).numPeople % 100 <
            15) {
      people = 'пациентов';
    } else if (cartItems.firstWhere((el) => el.id == widget.item.id).numPeople %
            10 ==
        1) {
      people = 'пациент';
    } else if (cartItems.firstWhere((el) => el.id == widget.item.id).numPeople %
                10 ==
            2 ||
        cartItems.firstWhere((el) => el.id == widget.item.id).numPeople % 10 ==
            3 ||
        cartItems.firstWhere((el) => el.id == widget.item.id).numPeople % 10 ==
            4) {
      people = 'пациента';
    } else {
      people = 'пациентов';
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 285,
                child: Text(
                  textAlign: TextAlign.left,
                  softWrap: true,
                  widget.item.name,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(0, 0, 0, 1.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                      onTap: () {
                        widget.deleteFromCart(widget.item.id);
                      },
                      child: Container(
                        color: const Color.fromRGBO(255, 0, 0, 0),
                        height: 20.0,
                        width: 20.0,
                        child: const ImageIcon(
                            AssetImage('assets/cart/Delete.png'),
                            color: Color.fromARGB(255, 126, 126, 154)),
                      )),
                ),
              ),
            ],
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
                    '${(widget.item.cost * cartItems.firstWhere((el) => el.id == widget.item.id).numPeople).toString()} ₽',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 17, color: Color.fromRGBO(0, 0, 0, 1.0))),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    '${cartItems.firstWhere((el) => el.id == widget.item.id).numPeople} $people',
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
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(245, 245, 249, 1.0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                    ),
                    /*shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                    ),*/
                    child: GestureDetector(
                      onTap: () {
                        widget.minusPeople(widget.item.id);
                        print('minus');
                      },
                      /*style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            const Color.fromRGBO(245, 245, 249, 1.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)),
                        ),
                      ),*/
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        child: const ImageIcon(
                          AssetImage('assets/cart/minus.png'),
                        ),
                        /*decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/cart/minus.png'),
                            fit: BoxFit.contain,
                          ),
                        ),*/
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
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(245, 245, 249, 1.0),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        widget.plusPeople(widget.item.id);
                        print('plus');
                      },
                      /*style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            const Color.fromRGBO(245, 245, 249, 1.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8)),
                        ),
                      ),*/
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        child: const ImageIcon(
                          AssetImage('assets/cart/plus.png'),
                        ),
                        /*decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/cart/minus.png'),
                            fit: BoxFit.contain,
                          ),
                        ),*/
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

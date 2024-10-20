import 'package:flutter/material.dart';
import 'package:pr7/components/cart_item_list.dart';
import 'package:pr7/models/info.dart' as info;
import 'package:google_fonts/google_fonts.dart';
import 'package:pr7/models/items.dart';
import 'package:pr7/models/cart.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  void plusPeople(int i) {
    setState(() {
      info.cartItems
          .elementAt(info.cartItems.indexWhere((el) => el.id == i))
          .numPeople += 1;
    });
  }

  void minusPeople(int i) {
    if (info.cartItems.firstWhere((el) => el.id == i).numPeople > 1) {
      setState(() {
        info.cartItems
            .elementAt(info.cartItems.indexWhere((el) => el.id == i))
            .numPeople -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          const SizedBox(
            height: 92,
          ),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 27.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Корзина',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 24,
                              color: Color.fromRGBO(0, 0, 0, 1),
                              fontWeight: FontWeight.w500),
                        )),
                    const SizedBox(
                      height: 38,
                    ),
                    Container(
                        /*decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 27, 86, 134), // Цвет фона
                          border: Border.all(
                            // Настройка границ
                            color: Colors.black, // Цвет границы
                            width: 1.0, // Ширина границы
                          ),
                        ),*/
                        height: (138.0 + 16.0) * info.items.length + 16,
                        child: ListView.builder(
                          itemCount: info.cartItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            Item itemM = info.items.firstWhere(
                                (el) => el.id == info.cartItems[index].id);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: CartItemListPage(
                                item: itemM,
                                plusPeople: (int num) => plusPeople(num),
                                minusPeople: (int num) => minusPeople(num),
                                //people: info.cartItems[index].numPeople,
                              ),
                            );
                          },
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

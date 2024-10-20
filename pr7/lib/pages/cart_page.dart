import 'package:flutter/material.dart';
import 'package:pr7/components/cart_item_list.dart';
import 'package:pr7/models/info.dart' as info;
import 'package:google_fonts/google_fonts.dart';
import 'package:pr7/models/items.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  List<Item> cartItemsList = info.items
      .where((el) => info.cartItems.any((i) => i.id == el.id))
      .toList();

  int totalSum = info.cartItems.fold(
      0,
      (sum, el) =>
          sum +
          el.numPeople * info.items.firstWhere((i) => i.id == el.id).cost);
  void plusPeople(int i) {
    setState(() {
      info.cartItems
          .elementAt(info.cartItems.indexWhere((el) => el.id == i))
          .numPeople += 1;
      totalSum = info.cartItems.fold(
          0,
          (sum, el) =>
              sum +
              el.numPeople *
                  info.items
                      .elementAt(info.items.indexWhere((i) => i.id == el.id))
                      .cost);
    });
  }

  void minusPeople(int i) {
    if (info.cartItems.firstWhere((el) => el.id == i).numPeople > 1) {
      setState(() {
        info.cartItems
            .elementAt(info.cartItems.indexWhere((el) => el.id == i))
            .numPeople -= 1;
        totalSum = info.cartItems.fold(
            0,
            (sum, el) =>
                sum +
                el.numPeople *
                    info.items
                        .elementAt(info.items.indexWhere((i) => i.id == el.id))
                        .cost);
      });
    }
  }

  void addToCartList(int id) {
    setState(() {
      if (info.cartItems.any((el) => el.id == id)) {
        info.cartItems.removeAt(info.cartItems.indexWhere((i) => i.id == id));
        cartItemsList = info.items
            .where((item) => info.cartItems.any((j) => j.id == item.id))
            .toList();
        totalSum = info.cartItems.fold(
            0,
            (sum, element) =>
                sum +
                element.numPeople *
                    info.items
                        .elementAt(
                            info.items.indexWhere((el) => el.id == element.id))
                        .cost);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          Column(
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
                        info.cartItems.isNotEmpty
                            ? Container(
                                /*decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                  255, 27, 86, 134), // Цвет фона
                              border: Border.all(
                                // Настройка границ
                                color: Colors.black, // Цвет границы
                                width: 1.0, // Ширина границы
                              ),
                            ),*/
                                height:
                                    (138.0 + 16.0) * info.cartItems.length + 16,
                                child: ListView.builder(
                                  itemCount: info.cartItems.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Item itemM = info.items.firstWhere((el) =>
                                        el.id == info.cartItems[index].id);
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: CartItemListPage(
                                        item: itemM,
                                        plusPeople: (int num) =>
                                            plusPeople(num),
                                        minusPeople: (int num) =>
                                            minusPeople(num),
                                        deleteFromCart: (int id) =>
                                            addToCartList(id),
                                      ),
                                    );
                                  },
                                ))
                            : Center(
                                child: Text(
                                  'В корзине ничего нет',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromRGBO(147, 147, 150, 1.0),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 40.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Сумма',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(0, 0, 0, 1.0),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                '$totalSum ₽',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(0, 0, 0, 1.0),
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          info.cartItems.isNotEmpty
              ? Positioned(
                  top: 670,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Container(
                      width: 335.0,
                      //height: 56.0,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(26, 111, 238, 1.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 18),
                              child: Text(
                                'Перейти к оформлению заказа',
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontSize: 17.0,
                                      color: Color.fromRGBO(255, 255, 255, 1.0),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
              : Container()
        ],
      ),
    );
  }
}

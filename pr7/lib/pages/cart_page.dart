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

  // сумма корзины
  int totalSum = info.cartItems.fold(
      0,
      (sum, el) =>
          sum +
          el.numPeople * info.items.firstWhere((i) => i.id == el.id).cost);

  // увеличение кол ва пациентов
  void plusPeople(int id) {
    setState(() {
      final cartItemIndex = info.cartItems.indexWhere((el) => el.id == id);
      if (cartItemIndex != -1) {
        info.cartItems[cartItemIndex].numPeople += 1;

        totalSum = info.cartItems.fold(
          0,
          (sum, el) =>
              sum +
              el.numPeople *
                  info.items.firstWhere((item) => item.id == el.id).cost,
        );
      }
    });
  }

  // уменьшение кол ва пациентов
  void minusPeople(int id) {
    setState(() {
      final cartItemIndex = info.cartItems.indexWhere((el) => el.id == id);

      if (cartItemIndex != -1 && info.cartItems[cartItemIndex].numPeople > 1) {
        info.cartItems[cartItemIndex].numPeople -= 1;
        totalSum = info.cartItems.fold(
          0,
          (sum, el) =>
              sum +
              el.numPeople *
                  info.items.firstWhere((item) => item.id == el.id).cost,
        );
      }
    });
  }

  // добавление к ркорзину
  void addToCartList(int id) {
    setState(() {
      final cartItemIndex = info.cartItems.indexWhere((el) => el.id == id);

      if (cartItemIndex != -1) {
        info.cartItems.removeAt(cartItemIndex);

        cartItemsList = info.items
            .where((item) => info.cartItems.any((j) => j.id == item.id))
            .toList();

        totalSum = info.cartItems.fold(
          0,
          (sum, element) =>
              sum +
              element.numPeople *
                  info.items.firstWhere((item) => item.id == element.id).cost,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27.0),
        child: Column(
          children: [
            const SizedBox(height: 92),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Корзина',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.w500),
                  )),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: info.cartItems.isNotEmpty
                  ? ListView.builder(
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
                            deleteFromCart: (int id) => addToCartList(id),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'В корзине ничего нет',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(147, 147, 150, 1.0),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
            ),
            if (info.cartItems.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
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
              ),
            if (info.cartItems.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 30.0),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(26, 111, 238, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'Перейти к оформлению заказа',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontSize: 17.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )),
              )
          ],
        ),
      ),
    );
  }
}

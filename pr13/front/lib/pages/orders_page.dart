import 'package:flutter/material.dart';
import 'package:front/models/order_model.dart';
import 'package:front/auth/auth_service.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/user_model.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key, required this.userId});

  final int userId;
  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  late Future<User> user;
  late Future<List<Order>> _orders;
  late List<Order> _ordersUpd;

  @override
  void initState() {
    super.initState();
    //user = ApiService().getUserById(1);
    //final currentEmail = AuthService().getCurrentUserEmail();
    //user = ApiService().getUserByEmail(currentEmail);
    _orders = ApiService().getOrders(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: const Text(
          'Мои заказы',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FutureBuilder<List<Order>>(
        future: _orders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data!.isEmpty ||
              snapshot.data == null) {
            return const Center(child: Text('Нет заказов'));
          }

          final items = snapshot.data!;
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final ord = items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),

                      //border: Border.all(color: Colors.black, width: 2.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Заказ №${ord.orderId}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Статус: ${ord.status}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 170,
                            child: SingleChildScrollView(
                              scrollDirection:
                                  Axis.horizontal, // Горизонтальная прокрутка
                              child: Row(
                                children: ord.products.map((item) {
                                  return Container(
                                    width: 150, // Ширина каждого элемента
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          item.imageUrl,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(item.name,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14)),
                                        //Text(item.price.toString()),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Сумма заказа: ${ord.total}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

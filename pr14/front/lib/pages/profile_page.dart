import 'package:flutter/material.dart';
import 'package:front/models/api_service.dart';
import 'package:front/pages/edit_user_page.dart';
import 'package:front/models/user_model.dart';
import 'package:front/auth/auth_service.dart';
import 'package:front/pages/orders_page.dart';
import 'package:front/pages/chat_page.dart';

class MyUserPage extends StatefulWidget {
  const MyUserPage({super.key});

  @override
  State<MyUserPage> createState() => _MyUserPageState();
}

class _MyUserPageState extends State<MyUserPage> {
  late Future<User> user;
  final authService = AuthService();
/*
  void _navigateToEditUserInfoScreen(BuildContext context) async {
    final User uinfo = await ApiService().getUserById(1);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyEditUserInfoPage(uinfo: uinfo)),
    );
    _refreshData();
    if (result != null) {
      _refreshData();
    }
  }*/

  @override
  void initState() {
    super.initState();
    //user = ApiService().getUserById(1);
    final currentEmail = authService.getCurrentUserEmail();
    user = ApiService().getUserByEmail(currentEmail);
  }

  void _refreshData() {
    final currentEmail = authService.getCurrentUserEmail();
    setState(() {
      user = ApiService().getUserByEmail(currentEmail);
    });
    /*
    setState(() {
      user = ApiService().getUserById(1);
    });*/
  }

  //final authService = AuthService();
  void logout() async {
    try {
      await authService.signOut();
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('error: $e')));
      }
    }
  }

  void getUserByE(email) async {
    try {
      await ApiService().getUserByEmail(email);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('error: $e')));
      }
    }
  }

  void _navigateToOrdersScreen(BuildContext context, userId) async {
    //final User uinfo = await ApiService().getUserById(1);
    print('_navigateToOrdersScreen function got called');
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyOrders(userId: userId)),
    );
  }

  void _navigateToChatScreen(BuildContext context, userId) async {
    //final User uinfo = await ApiService().getUserById(1);
    print('_navigateToChatScreen function got called');
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final currentEmail = authService.getCurrentUserEmail();

    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: FutureBuilder<User>(
          future: user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Ошибка: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('данных профиля нет'));
            }

            final userData = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: logout,
                      child: IconButton(
                        onPressed: logout,
                        icon: const Icon(Icons.exit_to_app),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ClipOval(
                      child: Image.network(
                        userData.image,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Text('Ошибка загрузки изображения');
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)),
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Color.fromRGBO(109, 109, 109, 1),
                              size: 25.0,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              userData.name,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              color: Color.fromRGBO(109, 109, 109, 1),
                              size: 25.0,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              userData.phoneNumber,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.mail,
                              color: Color.fromRGBO(109, 109, 109, 1),
                              size: 25.0,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              authService.getCurrentUserEmail().toString(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () =>
                        {_navigateToOrdersScreen(context, userData.id)},
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        //color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(109, 109, 109, 1),
                            width: 1.5,
                          ),
                        ),
                        //borderRadius: BorderRadius.circular(20.0))
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        child: Text(
                          'Мои заказы',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {_navigateToChatScreen(context, userData.id)},
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        //color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(109, 109, 109, 1),
                            width: 1.5,
                          ),
                        ),
                        //borderRadius: BorderRadius.circular(20.0))
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        child: Text(
                          'Чат',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
      /*
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            /*_navigateToEditUserInfoScreen(context);
            _refreshData();*/
          },
          tooltip: 'Изменить данные профиля',
          child: const Icon(Icons.edit),
        )*/
    );
  }
}

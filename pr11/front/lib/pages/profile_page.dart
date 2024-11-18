import 'package:flutter/material.dart';
import 'package:front/models/api_service.dart';
import 'package:front/pages/edit_user_page.dart';
import 'package:front/models/user_model.dart';
import 'package:front/auth/auth_service.dart';

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
                    child: Text(
                      userData.name,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 0, left: 10, right: 0, bottom: 5),
                    child: Text(
                      'Почта',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 77, 70, 0)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)),
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    child: Text(
                      authService.getCurrentUserEmail().toString(),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(top: 0, left: 10, right: 0, bottom: 5),
                    child: Text(
                      'Телефон',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 77, 70, 0)),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)),
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    child: Text(
                      userData.phoneNumber,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
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

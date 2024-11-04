import 'package:flutter/material.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/user_model.dart';

class MyEditUserInfoPage extends StatefulWidget {
  const MyEditUserInfoPage({super.key});

  @override
  State<MyEditUserInfoPage> createState() => _MyEditUserInfoPageState();
}

class _MyEditUserInfoPageState extends State<MyEditUserInfoPage> {
  late Future<User> user;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _profilePicController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void initState() {
    super.initState();
    ApiService().getUserById(1).then((i) => {
          _userNameController.text = i.name,
          _profilePicController.text = i.image,
          _emailController.text = i.email,
          _phoneController.text = i.phoneNumber
        });
  }

  void dispose() {
    _userNameController.dispose();
    _profilePicController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: const Text(
          "Изменение данных профиля",
          style: TextStyle(
            color: Colors.black,
            fontSize: 21.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 0, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Имя пользователя',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 77, 70, 0)),
                ),
              ),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'Имя пользователя',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(160, 149, 108, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 13.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Фото профиля',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 77, 70, 0)),
                ),
              ),
              TextField(
                controller: _profilePicController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'ссылка на фото профиля',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(160, 149, 108, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 13.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Почта',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 77, 70, 0)),
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'почта',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(160, 149, 108, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 13.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Телефон',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 77, 70, 0)),
                ),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'телефон',
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(160, 149, 108, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 13.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                    )),
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(145, 132, 85, 1),
                    backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 35.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                            width: 2, color: Color.fromRGBO(145, 132, 85, 1))),
                  ),
                  onPressed: () async {
                    if (_userNameController.text.isNotEmpty &&
                        _profilePicController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _phoneController.text.isNotEmpty) {
                      /*
                      User editInfo = User(
                        id: 1,
                        image: _profilePicController.text,
                        name: _userNameController.text,
                        email: _emailController.text,
                        phoneNumber: _phoneController.text,
                      );*/
                      await ApiService().updateUser(User(
                          id: 1,
                          image: _profilePicController.text,
                          name: _userNameController.text,
                          email: _emailController.text,
                          phoneNumber: _phoneController.text));
                      Navigator.pop(context);
                      print("Информация профиля обновлена");
                    } else {
                      print("Информация профиля НЕ обновлена");
                    }
                  },
                  child: const Text(
                    "Сохранить",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

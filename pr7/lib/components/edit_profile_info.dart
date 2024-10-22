import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pr7/models/info.dart' as info;
import 'package:pr7/models/user.dart' as user;

class MyEditProfileInfoPage extends StatefulWidget {
  const MyEditProfileInfoPage({super.key});

  @override
  State<MyEditProfileInfoPage> createState() => _MyEditProfileInfoPageState();
}

class _MyEditProfileInfoPageState extends State<MyEditProfileInfoPage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void initState() {
    super.initState();
    _userNameController.text = info.userInfo.name;
    _emailController.text = info.userInfo.email;
    _phoneController.text = info.userInfo.phone;
  }

  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 92,
              ),
              Padding(
                padding: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 5),
                child: Text(
                  'Имя пользователя',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(147, 147, 150, 1.0)),
                  ),
                ),
              ),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'Имя пользователя',
                    hintStyle: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(147, 147, 150, 1.0),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 13.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(147, 147, 150, 1.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(26, 111, 238, 1.0), width: 1),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 0, right: 0, bottom: 5),
                child: Text(
                  'Почта',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(147, 147, 150, 1.0)),
                  ),
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'почта',
                    hintStyle: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(147, 147, 150, 1.0),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 13.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(147, 147, 150, 1.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(26, 111, 238, 1.0), width: 1),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 0, right: 0, bottom: 5),
                child: Text(
                  'Телефон',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(147, 147, 150, 1.0)),
                  ),
                ),
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'телефон',
                    hintStyle: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(147, 147, 150, 1.0),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 13.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(147, 147, 150, 1.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(26, 111, 238, 1.0), width: 1),
                    )),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                width: 335.0,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (_userNameController.text.isNotEmpty &&
                            _emailController.text.isNotEmpty &&
                            _phoneController.text.isNotEmpty) {
                          user.User editInfo = user.User(
                            id: info.userInfo.id,
                            name: _userNameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                          );
                          info.userInfo = editInfo;
                          Navigator.pop(context, editInfo);
                          print("Информация профиля обновлена");
                        } else {
                          print("Информация профиля НЕ обновлена");
                        }
                      },
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
                        child: Text("Сохранить",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontSize: 17.0,
                                color: Color.fromRGBO(255, 255, 255, 1.0),
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

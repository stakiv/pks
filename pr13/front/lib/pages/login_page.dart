import 'package:flutter/material.dart';
import 'package:front/auth/auth_service.dart';
import 'package:front/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await authService.signInWithEmailPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Text(
                'Вход в аккаунт',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 21.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 50, left: 10, right: 0, bottom: 5),
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
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  hintText: 'example@gmail.com',
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
              padding: EdgeInsets.only(top: 0, left: 10, right: 0, bottom: 5),
              child: Text(
                'Пароль',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 77, 70, 0)),
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  filled: true,
                  //hintText: 'Qwerty1',
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
            ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromRGBO(145, 132, 85, 1),
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                      vertical: 13.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(
                          width: 2, color: Color.fromRGBO(145, 132, 85, 1))),
                ),
                child: const Text(
                  'Войти',
                  style: TextStyle(
                    //color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                )),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignupPage(),
                ),
              ),
              child: const Center(
                child: Text(
                  'Нет аккаунта? Зарегистрируйтесь',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 77, 70, 0)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
      appBar: AppBar(
        title: const Text(
          'Вход в аккаунт',
          style: TextStyle(
            color: Colors.black,
            fontSize: 21.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 0, bottom: 5),
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
                  hintText: 'Почта',
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
                  hintText: 'Пароль',
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
              height: 30,
            ),
            ElevatedButton(onPressed: login, child: const Text('Войти')),
            const SizedBox(
              height: 20,
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

import 'package:flutter/material.dart';

const Color whitem = Color(0xFFFFFFFF); //white
const Color lightPink = Color(0xFFF8BBD0);
const Color bluee = Color(0xFF2962FF);
const Color blackk = Color(0xFF000000); //black
const Color lightGrey = Color(0xFFEEEEEE);
const Color darkGrey = Color(0xFF757575);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Авторизация',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: lightPink,
        ).copyWith(
          onSecondary: darkGrey,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitem,
      appBar: AppBar(
        backgroundColor: whitem,
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Авторизация',
                style: TextStyle(
                    color: blackk, fontSize: 30, fontWeight: FontWeight.w600)),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    style: const TextStyle(fontSize: 20, color: blackk),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: lightGrey,
                      hintText: "Логин",
                      hintStyle: const TextStyle(color: darkGrey),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 13.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: darkGrey, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    style: const TextStyle(fontSize: 20, color: blackk),
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: lightGrey,
                      hintText: "Пароль",
                      hintStyle: const TextStyle(color: darkGrey),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 13.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: darkGrey, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value ?? false;
                              });
                            },
                            side: const BorderSide(color: darkGrey, width: 1.5),
                            checkColor: darkGrey,
                            fillColor: MaterialStateProperty.all(whitem),
                          ),
                          const Text(
                            'Запомнить меня',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 37),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: bluee,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 30.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                                width: 2, color: Colors.transparent)),
                      ),
                      child:
                          const Text("Войти", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: bluee,
                        backgroundColor: whitem,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 30.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side:
                                const BorderSide(width: 2, color: Colors.blue)),
                      ),
                      child: const Text("Регистрация",
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text("Восстановить пароль",
                      style: TextStyle(fontSize: 18, color: darkGrey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

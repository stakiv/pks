import 'package:flutter/material.dart';

const Color whitem = Color(0xFFFFFFFF); //white
const Color lightPink = Color(0xFFF8BBD0);
const Color darkPink = Color(0xFF880E4F);
const Color blackk = Color(0xFF000000); //black
const Color lightGrey = Color(0xFFEEEEEE);

const Color light = Color(0x101010);
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
            background: whitem,
            secondary: light,
            onPrimary: darkPink,
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
              Text(
                'Авторизация',
                style: TextStyle(color: blackk, fontSize: 30)
              ),
              const SizedBox(height: 70),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(style: TextStyle(fontSize: 20, color: light), decoration: InputDecoration(
                      filled: true,
                      fillColor: lightGrey,
                      hintText: "Логин",
                      hintStyle: TextStyle(color: darkGrey),
                      contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 13.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Задание радиуса углов
                        borderSide: const BorderSide(color: Colors.transparent), // Прозрачный цвет границы
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Задание радиуса углов
                        borderSide: const BorderSide(color: light, width: 2), // Прозрачный цвет границы
                      ),
                    ),
                    ),
                    const SizedBox(height: 20),
                    TextField(style: TextStyle(fontSize: 20, color: light), decoration: InputDecoration(
                      filled: true,
                      fillColor: lightGrey,
                      hintText: "Пароль",
                      hintStyle: TextStyle(color: darkGrey),
                      contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 13.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Задание радиуса углов
                        borderSide: const BorderSide(color: Colors.transparent), // Прозрачный цвет границы
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Задание радиуса углов
                        borderSide: const BorderSide(color: light, width: 2), // Прозрачный цвет границы
                      ),
                    ),
                    ),
                    SizedBox(height: 15),
                    CheckboxListTile(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text('Запомнить меня', style: TextStyle(fontSize: 18, color: darkGrey)), 
                      activeColor: darkGrey,
                      checkColor: lightGrey,
                      contentPadding: const EdgeInsets.all(0), // Удаление лишнего padding
                    ),
                    const SizedBox(height: 37),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: darkPink,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(width: 2, color: Colors.transparent)
                          ),
                        ),
                        child: Text("Войти", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: darkPink,
                          backgroundColor: whitem,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(width: 2, color: darkPink)
                          ),
                        ),
                        child: Text("Регистрация", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text("Восстановить пароль", style: TextStyle(fontSize: 18, color: darkGrey)),
                    
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
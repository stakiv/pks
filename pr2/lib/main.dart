import 'package:flutter/material.dart';

const Color whitem = Color(0x101010);
const Color lightPink = Color(0xFFF8BBD0);
const Color darkPink = Color(0xFF880E4F);
const Color light = Color(0xFFFFFFFF);
const Color dark = Color(0xFF303030);
const Color lightGrey = Color(0xFF616161);

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
            primary: lightPink,
            onPrimary: darkPink,
            onSecondary: dark,
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      
      body: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center, 
            children: <Widget>[
              Text(
                'Авторизация',
                style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 30)
              ),
              const SizedBox(height: 70),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(style: TextStyle(fontSize: 20, color: light), decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onSecondary,
                      hintText: "Логин",
                      hintStyle: TextStyle(color: lightGrey),
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
                      fillColor: Theme.of(context).colorScheme.onSecondary,
                      hintText: "Пароль",
                      hintStyle: TextStyle(color: lightGrey),
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
                      title: Text('Запомнить меня', style: TextStyle(fontSize: 18, color: lightGrey)), 
                      activeColor: lightGrey,
                      checkColor: dark,
                      contentPadding: const EdgeInsets.all(0), // Удаление лишнего padding
                    ),
                    const SizedBox(height: 37),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.pink,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(width: 2, color: Colors.black)
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
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          backgroundColor: Theme.of(context).colorScheme.background,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(width: 2, color: Theme.of(context).colorScheme.onPrimary)
                          ),
                        ),
                        child: Text("Регистрация", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text("Восстановить пароль", style: TextStyle(fontSize: 18, color: lightGrey)),
                    
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}

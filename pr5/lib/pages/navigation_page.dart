import 'package:flutter/material.dart';
import 'package:pr5/pages/favorites_page.dart';
import 'package:pr5/pages/home_page.dart';
import 'package:pr5/pages/profile_page.dart';

class MyNavigationPage extends StatefulWidget {
  const MyNavigationPage({super.key});

  @override
  State<MyNavigationPage> createState() => _MyNavigationPageState();
}

class _MyNavigationPageState extends State<MyNavigationPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    MyFavouritesPage(),
    MyUserPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 248, 225, 1),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Главная"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Избранное"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Профиль"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 72, 67, 51),
        onTap: _onItemTapped,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:pr7/pages/home_page.dart';
import 'package:pr7/pages/cart_page.dart';
import 'package:pr7/pages/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MyNavigationPage extends StatefulWidget {
  const MyNavigationPage({super.key});

  @override
  State<MyNavigationPage> createState() => _MyNavigationPageState();
}

class _MyNavigationPageState extends State<MyNavigationPage> {
  int _selectedPage = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    MyCartPage(),
    MyProfilePage()
  ];

  // обработка нажатия
  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: _widgetOptions.elementAt(_selectedPage),
      bottomNavigationBar: Container(
        height: 69,
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image.asset('assets/nav/homee_icon.png'),
                activeIcon: Image.asset('assets/nav/select_homee_icon.png'),
                label: 'Главная'),
            BottomNavigationBarItem(
                icon: Image.asset('assets/nav/cart_icon.png'),
                activeIcon: Image.asset('assets/nav/select_cart_icon.png'),
                label: 'Корзина'),
            BottomNavigationBarItem(
                icon: Image.asset('assets/nav/user_icon.png'),
                activeIcon: Image.asset('assets/nav/select_user_icon.png'),
                label: 'Профиль'),
          ],
          currentIndex: _selectedPage,
          onTap: _onItemTapped,
          selectedItemColor: const Color.fromRGBO(26, 111, 238, 1.0),
          unselectedItemColor: const Color.fromRGBO(137, 138, 141, 1.0),
          selectedLabelStyle: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Color.fromRGBO(26, 111, 238, 1.0)),
          ),
          unselectedLabelStyle: GoogleFonts.montserrat(
            textStyle: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: Color.fromRGBO(137, 138, 141, 1.0)),
          ),
        ),
      ),
    );
  }
}

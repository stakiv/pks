import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:pr7/models/info.dart' as info;
import 'package:pr7/components/home_item_list.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 27.0),
          children: [
            const SizedBox(
              height: 92,
            ),
            Text('Каталог услуг',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 24,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontWeight: FontWeight.w500),
                )),
            const SizedBox(
              height: 38,
            ),
            ...info.items.map((el) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: HomeItemListPage(
                  id: el.id,
                  name: el.name,
                  numDays: el.numDays,
                  cost: el.cost,
                ),
              );
            }).toList(),
          ],
        ));
  }
}

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
        )
        /*
      Column(
        children: [
          
          
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 27.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Container(
                          /*decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 27, 86, 134), // Цвет фона
                          border: Border.all(
                            // Настройка границ
                            color: Colors.black, // Цвет границы
                            width: 1.0, // Ширина границы
                          ),
                        ),*/
                          height: (138.0 + 16.0) * info.items.length + 16,
                          child: ListView.builder(
                            itemCount: info.items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: HomeItemListPage(
                                  id: info.items[index].id,
                                  name: info.items[index].name,
                                  numDays: info.items[index].numDays,
                                  cost: info.items[index].cost,
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                  //const SizedBox(height: 38,),
                ),
              ),
            ),
          
        ],
      ),*/
        );
  }
}

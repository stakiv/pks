import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeItemListPage extends StatelessWidget {
  const HomeItemListPage(
      {super.key,
      required this.name,
      required this.numDays,
      required this.cost});

  final String name;
  final int numDays;
  final int cost;

  @override
  Widget build(BuildContext context) {
    String days;
    if (numDays % 10 == 1) {
      days = 'день';
    } else if (numDays % 10 == 2 || numDays % 10 == 3 || numDays % 10 == 4) {
      days = 'дня';
    } else {
      days = 'дней';
    }
    return Container(
      decoration: BoxDecoration(
        //color: const Color.fromARGB(255, 32, 134, 27),
        border: Border.all(
          width: 1,
          color: const Color.fromRGBO(224, 224, 224, 1.0),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16.0),
      width: 335,
      //height: 138,
      child: Column(
        children: [
          Text(
            name,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(0, 0, 0, 1.0),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${numDays.toString()} $days',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(147, 147, 150, 1.0))),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    '${cost.toString()} ₽',
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 17, color: Color.fromRGBO(0, 0, 0, 1.0))),
                  )
                ],
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  foregroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
                  backgroundColor: const Color.fromRGBO(26, 111, 238, 1.0),
                ),
                child: Text(
                  'Добавить',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(255, 255, 255, 1.0),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

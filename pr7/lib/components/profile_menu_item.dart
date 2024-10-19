import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMenuItemPage extends StatelessWidget {
  const ProfileMenuItemPage(
      {super.key, required this.name, required this.icon});

  final String name;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 18, bottom: 19),
        /*decoration: BoxDecoration(
          color: const Color.fromARGB(255, 101, 121, 137),
          border: Border.all(
            color: const Color.fromARGB(255, 20, 165, 15),
            width: 1.0,
          ),
        ),*/
        width: 335,
        //height: 65,
        child: Row(
          children: [
            Image.asset(icon, width: 32, height: 32),
            const SizedBox(width: 20),
            Text(
              name,
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 17,
                  color: Color.fromRGBO(0, 0, 0, 1.0),
                  //height: 1.4
                ),
              ),
            )
          ],
        ));
  }
}

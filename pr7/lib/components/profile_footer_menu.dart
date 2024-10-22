import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileFooterMenuPage extends StatelessWidget {
  const ProfileFooterMenuPage({
    super.key,
    required this.item1,
    required this.item2,
    required this.item3,
    required this.item4,
  });

  final String item1;
  final String item2;
  final String item3;
  final String item4;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 27.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(item1,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(147, 147, 150, 1.0),
                        fontWeight: FontWeight.w300,
                        height: 1.5),
                  )),
              const SizedBox(
                height: 24,
              ),
              Text(item2,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(147, 147, 150, 1.0),
                        fontWeight: FontWeight.w300,
                        height: 1.5),
                  )),
              const SizedBox(height: 24),
              Text(item3,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(147, 147, 150, 1.0),
                        fontWeight: FontWeight.w300,
                        height: 1.5),
                  )),
              const SizedBox(height: 24),
              Text(item4,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(253, 53, 53, 1.0),
                        fontWeight: FontWeight.w300,
                        height: 1.5),
                  ))
            ],
          ),
        ));
  }
}

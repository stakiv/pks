import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInfoPage extends StatelessWidget {
  const ProfileInfoPage(
      {super.key,
      required this.name,
      required this.phone,
      required this.email});

  final String name;
  final String phone;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 27.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(0, 0, 0, 1.0),
                        fontWeight: FontWeight.w500),
                  )),
              const SizedBox(height: 22),
              Text(phone,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(137, 138, 141, 1.0),
                        fontWeight: FontWeight.w500),
                  )),
              const SizedBox(height: 16),
              Text(email,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(137, 138, 141, 1.0),
                        fontWeight: FontWeight.w500),
                  ))
            ],
          ),
        ));
  }
}

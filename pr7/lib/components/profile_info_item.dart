import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pr7/models/info.dart';
import 'package:pr7/components/edit_profile_info.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({
    super.key,
    /*required this.user,
    required this.phone,
      required this.email*/
  });

  /*final String user;
  final String phone;
  final String email;*/

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  /*void _navigateToEditUserInfoScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyEditProfileInfoPage()),
    );
    if (result != null) {
      setState(() {});
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 27.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(userInfo.name,
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 24,
                            color: Color.fromRGBO(0, 0, 0, 1.0),
                            fontWeight: FontWeight.w500),
                      )),
                  /*
                  GestureDetector(
                    child: Icon(Icons.edit),
                    onTap: () => _navigateToEditUserInfoScreen(context),
                  )*/
                ],
              ),
              const SizedBox(height: 22),
              Text(userInfo.phone,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(137, 138, 141, 1.0),
                        fontWeight: FontWeight.w500),
                  )),
              const SizedBox(height: 16),
              Text(userInfo.email,
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

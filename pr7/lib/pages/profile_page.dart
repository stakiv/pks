import 'package:flutter/material.dart';
import 'package:pr7/components/profile_info_item.dart';
import 'package:pr7/components/profile_menu_item.dart';
import 'package:pr7/components/profile_footer_menu.dart';
import 'package:pr7/models/info.dart' as info;

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 92,
              ),
              const ProfileInfoPage(
                  /*user: info.userInfo,
                phone: info.profileInfo[1],
                  email: info.profileInfo[2]*/
                  ),
              const SizedBox(
                height: 48,
              ),
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Container(
                  height: 285,
                  child: ListView.builder(
                      itemCount: info.profileItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 27.0, vertical: 0.0),
                          child: ProfileMenuItemPage(
                              name: info.profileItems[index].name,
                              icon: info.profileItems[index].icon),
                        );
                      }),
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              ProfileFooterMenuPage(
                  item1: info.footerMenu[0],
                  item2: info.footerMenu[1],
                  item3: info.footerMenu[2],
                  item4: info.footerMenu[3]),
            ],
          ),
        ],
      ),
    );
  }
}

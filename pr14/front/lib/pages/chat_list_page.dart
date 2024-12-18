import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:front/pages/chat_page.dart';
import 'package:front/models/user_model.dart';
import 'package:front/models/api_service.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late Future<List<User>> users;

  void _navigateToChatScreen(BuildContext context, userEmail) async {
    //final User uinfo = await ApiService().getUserById(1);
    print('_navigateToChatScreen function got called');
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ChatPage(senderEmail: 'admin@mail.ru', receiverEmail: userEmail)),
    );
  }

  @override
  void initState() {
    super.initState();
    users = ApiService().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: const Text(
          'Чаты с покупателями',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.amber[50],
      ),
      body: FutureBuilder<List<User>>(
          future: users,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Ошибка загрузки чатов');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            final us = snapshot.data!;
            return ListView.builder(
              itemCount: us.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 6.0, left: 10.0, right: 10.0),
                  child: GestureDetector(
                    onTap: () =>
                        _navigateToChatScreen(context, us[index].email),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 252, 252, 252),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.10,
                              height: MediaQuery.of(context).size.width * 0.10,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(us[index].image),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              us[index].email,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                //fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}

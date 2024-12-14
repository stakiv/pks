import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  void _sendText() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Чат с продавцом',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 248, 225, 1),
      ),
      backgroundColor: const Color.fromRGBO(255, 248, 225, 1),
      body: Column(
        children: [
          Column(
            children: [
              Text('чат'),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    filled: true,
                    hintText: "Введите сообщение...",
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(160, 149, 108, 1),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13.0, horizontal: 13.0),
                  ),
                  onChanged: (value) {
                    /*
                          setState(() {
                            searchQuery = value;
                            _filterProducts(searchQuery);
                          });*/
                  },
                ),
              ),
              SizedBox(
                width: 8,
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendText,
              ),
            ],
          )
        ],
      ),
    );
  }
}

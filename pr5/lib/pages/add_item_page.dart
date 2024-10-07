import 'package:flutter/material.dart';
import 'package:pr5/models/flavor.dart';
import 'package:pr5/models/info.dart' as info;

class AddFlavorScreen extends StatefulWidget {
  @override
  _AddFlavorScreenState createState() => _AddFlavorScreenState();
}

class _AddFlavorScreenState extends State<AddFlavorScreen> {
  final TextEditingController _nameFlavorController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dopController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  int listLength = info.flavors.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: const Text(
          "Добавить новый вкус",
          style: TextStyle(
            color: Colors.black,
            fontSize: 21.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: _nameFlavorController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  hintText: "Название вкуса",
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(160, 149, 108, 1),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 13.0, horizontal: 13.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  hintText: "Ссылка на картинку",
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(160, 149, 108, 1),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 13.0, horizontal: 13.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  hintText: "Описание",
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(160, 149, 108, 1),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 13.0, horizontal: 13.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _dopController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  hintText: "Дополнительная информация",
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(160, 149, 108, 1),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 13.0, horizontal: 13.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  hintText: "Цена",
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(160, 149, 108, 1),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 13.0, horizontal: 13.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                  )),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromRGBO(145, 132, 85, 1),
                backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                    vertical: 13.0, horizontal: 30.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(
                        width: 2, color: Color.fromRGBO(145, 132, 85, 1))),
              ),
              onPressed: () {
                listLength += 1;
                int price = int.parse(_priceController.text);

                if (_nameFlavorController.text.isNotEmpty &&
                    _imageController.text.isNotEmpty &&
                    _descController.text.isNotEmpty &&
                    _dopController.text.isNotEmpty &&
                    _priceController.text.isNotEmpty) {
                  Flavor newFlavor = Flavor(
                      listLength,
                      _nameFlavorController.text,
                      _imageController.text,
                      _descController.text,
                      _dopController.text,
                      price,
                      false);
                  Navigator.pop(context, newFlavor);
                  print("новый вкус создан");
                } else {
                  print("не все поля заполнены");
                }
              },
              child: const Text(
                "Сохранить",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

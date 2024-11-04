import 'package:flutter/material.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/product_model.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key, required this.flavor});
  final Product flavor;
  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late Future<Product> item;
  final TextEditingController _nameFlavorController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _dopController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void initState() {
    super.initState();
    ApiService().getProductById(widget.flavor.id).then((i) => {
          _nameFlavorController.text = i.name,
          _imageController.text = i.imageUrl,
          _descController.text = i.description,
          _dopController.text = i.feature,
          _priceController.text = i.price.toString(),
        });
  }

  void dispose() {
    _nameFlavorController.dispose();
    _imageController.dispose();
    _descController.dispose();
    _dopController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: const Text(
          "Изменение данных продукта",
          style: TextStyle(
            color: Colors.black,
            fontSize: 21.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 0, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Название вкуса',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 77, 70, 0)),
                ),
              ),
              TextField(
                controller: _nameFlavorController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'Имя пользователя',
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
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'фото продукта',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 77, 70, 0)),
                ),
              ),
              TextField(
                controller: _imageController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'ссылка на фото продукта',
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
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Описание',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 77, 70, 0)),
                ),
              ),
              TextField(
                controller: _descController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'Описание',
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
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Особенности',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 77, 70, 0)),
                ),
              ),
              TextField(
                controller: _dopController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'Особенности',
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
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 0, bottom: 5),
                child: Text(
                  'Цена',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 77, 70, 0)),
                ),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'Цена',
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
                height: 60,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(145, 132, 85, 1),
                    backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 35.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(
                            width: 2, color: Color.fromRGBO(145, 132, 85, 1))),
                  ),
                  onPressed: () async {
                    double price = double.parse(_priceController.text);
                    if (_nameFlavorController.text.isNotEmpty &&
                        _imageController.text.isNotEmpty &&
                        _descController.text.isNotEmpty &&
                        _dopController.text.isNotEmpty &&
                        _priceController.text.isNotEmpty) {
                      await ApiService().changeProductStatus(Product(
                          id: widget.flavor.id,
                          name: _nameFlavorController.text,
                          imageUrl: _imageController.text,
                          description: _descController.text,
                          feature: _dopController.text,
                          price: price,
                          isFavourite: widget.flavor.isFavourite,
                          isInCart: widget.flavor.isInCart,
                          quantity: widget.flavor.quantity));
                      Navigator.pop(context);
                      print("Информация товара обновлена");
                    } else {
                      print("Информация товара НЕ обновлена");
                    }
                  },
                  child: const Text(
                    "Сохранить",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

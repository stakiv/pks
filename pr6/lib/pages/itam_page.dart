import 'package:flutter/material.dart';
import 'package:pr6/models/info.dart' as info;
import 'package:pr6/models/flavor.dart';

class ItamPage extends StatefulWidget {
  const ItamPage({
    super.key,
    required this.flavor,
    required this.onAddToFavourites,
    required this.onAddToCart,
  });
  final Flavor flavor;
  final Function onAddToFavourites;
  final Function onAddToCart;

  @override
  State<ItamPage> createState() => _ItamPageState();
}

class _ItamPageState extends State<ItamPage> {
  int findIndexById(int id) {
    return info.flavors.indexWhere((item) => item.id == id);
  }

  void deleteItem(int i, BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 255, 246, 218),
        title: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: const Padding(
            padding: EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
            child: Center(
              child: Text(
                'Удалить карточку товара?',
                style: TextStyle(fontSize: 16.00, color: Colors.black),
              ),
            ),
          ),
        ),
        content: const Padding(
          padding: EdgeInsets.only(right: 8.0, left: 8.0),
          /*child: Text(
            'После удаления востановить товар будет невозможно',
            style: TextStyle(fontSize: 14.00, color: Colors.black),
            softWrap: true,
            textAlign: TextAlign.justify,
            textDirection: TextDirection.ltr,
          ),*/
        ),
        actions: [
          TextButton(
            child: const Text('Отмена',
                style: TextStyle(color: Colors.black, fontSize: 14.0)),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          TextButton(
            //style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[700]),
            child: const Text('Удалить',
                style: TextStyle(color: Colors.black, fontSize: 14.0)),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    ).then((bool? isDeleted) {
      if (isDeleted != null && isDeleted) {
        setState(() {
          if (info.cartFlavors.any((cartFl) => cartFl.id == i)) {
            info.cartFlavors.removeWhere((cartFl) => cartFl.id == i);
          }
          if (info.favouriteFlavors.any((el) => el == i)) {
            info.favouriteFlavors.remove(i);
          }
          Navigator.pop(context, findIndexById(i));
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${info.flavors.firstWhere((flavor) => flavor.id == i).flavorName} удален',
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 16.0),
            ),
            backgroundColor: const Color.fromRGBO(60, 60, 60, 1),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isFavourite = info.favouriteFlavors.contains(widget.flavor.id);
    bool isInCart =
        info.cartFlavors.any((flavorId) => flavorId.id == widget.flavor.id);
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text(
          widget.flavor.flavorName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 21.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        padding: const EdgeInsets.all(1),
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      widget.onAddToFavourites(widget.flavor);
                    },
                    icon: isFavourite
                        ? const Icon(Icons.favorite,
                            color: Color.fromRGBO(160, 149, 108, 1))
                        : const Icon(Icons.favorite_border,
                            color: Color.fromRGBO(160, 149, 108, 1)),
                  ),
                  const SizedBox(width: 30.0),
                  IconButton(
                    onPressed: () {
                      widget.onAddToCart(widget.flavor);
                    },
                    icon: isInCart
                        ? const Icon(Icons.shopping_cart,
                            color: Color.fromRGBO(160, 149, 108, 1))
                        : const Icon(Icons.add_shopping_cart,
                            color: Color.fromRGBO(160, 149, 108, 1)),
                  ),
                ],
              ),
              const SizedBox(
                height: 3.0,
              ),
              Image.network(
                widget.flavor.image,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 50.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Описание",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  Flexible(
                    child: Text(
                      widget.flavor.description,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Особенности",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  Flexible(
                    child: Text(
                      widget.flavor.feature,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "Цена",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  Flexible(
                    child: Text(
                      widget.flavor.price.toString(),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        deleteItem(widget.flavor.id, context);
                      },
                      child: Text('Удалить'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

  void deleteItem(int idM, BuildContext context) {
    int flavIndex = info.flavors.indexWhere((element) => element.id == idM);
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Padding(
            padding: EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Удалить ${info.flavors[flavIndex].flavorName}?',
                    style: TextStyle(fontSize: 14.00, color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  Image.network(
                    info.flavors[flavIndex].image,
                    width: 110,
                    height: 110,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Text(
                  'Отмена',
                  style: TextStyle(
                      color: Color.fromARGB(255, 75, 75, 75), fontSize: 14.0),
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              const SizedBox(width: 20),
              TextButton(
                child: const Text(
                  'Удалить',
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        ],
      ),
    ).then((bool? isDeleted) {
      if (isDeleted != null && isDeleted) {
        setState(() {
          if (info.cartFlavors.any((cartFl) => cartFl.id == idM)) {
            info.cartFlavors.removeWhere((cartFl) => cartFl.id == idM);
          }
          if (info.favouriteFlavors.any((el) => el == idM)) {
            info.favouriteFlavors.remove(idM);
          }
          Navigator.pop(context, findIndexById(idM));
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${info.flavors.firstWhere((flavor) => flavor.id == idM).flavorName} удален',
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
                  const SizedBox(
                    height: 35.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          deleteItem(widget.flavor.id, context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromRGBO(204, 194, 153, 1),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 60.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          'Удалить',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

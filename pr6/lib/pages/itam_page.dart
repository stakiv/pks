import 'package:flutter/material.dart';
import 'package:pr6/models/info.dart' as info;
import 'package:pr6/models/flavor.dart';

class ItamPage extends StatefulWidget {
  const ItamPage({
    super.key,
    required this.flavor,
    /*required this.onDelete*/
  });
  final Flavor flavor;
  //final Function onDelete;

  @override
  State<ItamPage> createState() => _ItamPageState();
}

class _ItamPageState extends State<ItamPage> {
  /*
  void _removeFlavor() async {
    bool? confirmed =
        await _showConfirmedDialog(context, 'Удалить элемент?', widget.flavor);
    if (confirmed == true) {
      int id = widget.flavor.id;
      setState(() {
        info.flavors.removeWhere((f) => f.id == widget.flavor.id);

        info.favouriteFlavors
            .removeWhere((element) => element == widget.flavor.id);
        info.cartFlavors.removeWhere((element) => element == widget.flavor.id);
      });
      //widget.onDelete();
      if (!(info.cartFlavors.contains(widget.flavor.id) &&
          info.favouriteFlavors.contains(widget.flavor.id) &&
          info.flavors.contains(widget.flavor))) {
        print('удалился 111111 ${widget.flavor.flavorName}');
      } else {
        print('неаааа');
      }

      Navigator.pop(context, widget.flavor);
    }
  }*/

  int findIndexById(int id) {
    return info.flavors.indexWhere((item) => item.id == id);
  }

  void remItem(int i, BuildContext context) {
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
          if (info.cartFlavors.any((el) => el == i)) {
            info.cartFlavors.removeWhere((el) => el == i);
          }
          if (info.favouriteFlavors.any((el) => el == i)) {
            info.favouriteFlavors.remove(i);
          }
          Navigator.pop(context, findIndexById(i));
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Товар успешно удален',
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
            backgroundColor: Colors.amber[700],
          ),
        );
      }
    });
  }
  /*
  Future<bool?> _showConfirmedDialog(
      BuildContext context, String title, Flavor flavor) {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(
                  flavor.image,
                  width: 150,
                  height: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Ошибка загрузки изображения');
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(flavor.flavorName),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  "Отмена",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(160, 149, 108, 1),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  "Удалить",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromRGBO(118, 103, 49, 1),
                  ),
                ),
              ),
            ],
          );
        });
  }*/

  @override
  Widget build(BuildContext context) {
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
                        remItem(widget.flavor.id, context);
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

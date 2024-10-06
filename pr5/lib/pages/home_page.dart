import 'package:flutter/material.dart';
import 'package:pr5/components/list_item.dart';
import 'package:pr5/models/flavor.dart';
import 'package:pr5/models/info.dart' as info;
import 'package:pr5/pages/add_item_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _navigateToAddFlavorScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddFlavorScreen()),
    );
    if (result != null) {
      setState(() {
        info.flavors.add(result as Flavor);
      });
    }
  }

  void _removeFlavor(int index) async {
    bool? confirmed = await _showConfirmedDialog(
        context, 'Удалить элемент?', info.flavors[index]);
    if (confirmed == true) {
      setState(() {
        info.flavors.removeAt(index);
        info.favouriteFlavors.removeWhere((element) => element == index);
      });
    }
  }

  void _addToFavorites(int index) async {
    if (info.favouriteFlavors.contains(index)) {
      setState(() {
        info.favouriteFlavors.removeWhere((element) => element == index);
      });
    } else {
      setState(() {
        info.favouriteFlavors.add(index);
      });
    }
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber[50],
        appBar: AppBar(
          title: const Text(
            "Вкусы мороженого",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: const Color.fromRGBO(255, 248, 225, 1),
        ),
        body: info.flavors.isEmpty
            ? const Center(
                child: Text('Вкусы не добавлены'),
              )
            : ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                itemCount: info.flavors.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: ListItem(
                      flavor: info.flavors[index],
                      onDelete: (flavor) {
                        _removeFlavor(info.flavors.indexOf(flavor));
                      },
                      onAdd: (flavor) {
                        _addToFavorites(info.flavors.indexOf(flavor));
                      },
                    ),
                  );
                }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToAddFlavorScreen(context),
          tooltip: 'Добавить вкус',
          child: const Icon(Icons.add),
        ));
  }
}

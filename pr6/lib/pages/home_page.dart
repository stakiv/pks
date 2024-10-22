import 'package:flutter/material.dart';
import 'package:pr6/components/list_item.dart';
import 'package:pr6/models/cartFlavor.dart';
import 'package:pr6/models/flavor.dart';
import 'package:pr6/models/info.dart';
import 'package:pr6/pages/add_item_page.dart';
import 'package:pr6/pages/itam_page.dart';
import 'package:pr6/models/cartFlavor.dart';

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
        flavors.add(result as Flavor);
      });
    }
  }

  int findIndexById(int id) {
    return flavors.indexWhere((item) => item.id == id);
  }

  void _addToFavorites(int i) {
    setState(() {
      if (favouriteFlavors.contains(i)) {
        favouriteFlavors.remove(i);
      } else {
        favouriteFlavors.add(i);
      }
    });
  }

  void addTOCart(int i) {
    setState(() {
      if (!cartFlavors.any((item) => item.id == i)) {
        cartFlavors.add(CartFlavor(i, 1));
      } else {
        cartFlavors.removeAt(cartFlavors.indexWhere((item) => item.id == i));
      }
    });
  }

  void _openItem(id) async {
    //print('Попал 0');
    int? answer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItamPage(
          flavor: flavors.elementAt(flavors.indexWhere((el) => el.id == id)),
          onAddToFavourites: (flavor) => {_addToFavorites(flavor)},
          onAddToCart: (flavor) => {addTOCart(flavor)},
          /*onDelete: widget.onDelete: () {
            widget.onDelete(widget.flavor);
            Navigator.pop(context);
          },*/
        ),
      ),
    );
    setState(() {
      //print('Попал 1');
      if (answer != null) {
        flavors
            .remove(flavors.elementAt(flavors.indexWhere((el) => el.id == id)));
        favouriteFlavors.removeWhere((id) =>
            id ==
            flavors.elementAt(flavors.indexWhere((el) => el.id == id)).id);
        cartFlavors.removeWhere((flId) =>
            flId.id ==
            flavors.elementAt(flavors.indexWhere((el) => el.id == id)).id);
      }
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
        body: flavors.isEmpty
            ? const Center(
                child: Text('Вкусы не добавлены'),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.61,
                  //crossAxisSpacing: 10.0,
                  //mainAxisSpacing: 15.0
                ),
                itemCount: flavors.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListItem(
                      flavor: flavors[index],
                      //onDelete: (flavor) => deleteItem(flavor.id, context),
                      onAddToFavourites: (flavor) =>
                          {_addToFavorites(flavor.id)},
                      onAddToCart: (flavor) => {addTOCart(flavor.id)},
                      NavToItemPage: (int i) => {_openItem(i)},
                    ),
                  );
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToAddFlavorScreen(context),
          tooltip: 'Добавить вкус',
          child: const Icon(Icons.add),
        ));
  }
}

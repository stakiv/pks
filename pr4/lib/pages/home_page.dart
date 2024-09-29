import 'package:flutter/material.dart';
import 'package:pr4/components/list_item.dart';
import 'package:pr4/models/flavor.dart';
import 'package:pr4/models/info.dart' as info;

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
      print('добавление нового вкуса $result');
      setState(() {
        info.flavors.add(result as Flavor);
      });
    }
  }

  void _removeFlavor(int index) {
    setState(() {
      info.flavors.removeAt(index);
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
                    ),
                  );
                }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToAddFlavorScreen(context),
          child: Icon(Icons.add),
          tooltip: 'Добавить вкус',
        ));
  }
}

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
      appBar: AppBar(
        title: const Text("Добавить новый вкус"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _nameFlavorController,
              decoration: const InputDecoration(labelText: "Введите название"),
            ),
            TextField(
              controller: _imageController,
              decoration:
                  const InputDecoration(labelText: "Ссылка на картинку"),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: "Описание"),
            ),
            TextField(
              controller: _dopController,
              decoration:
                  const InputDecoration(labelText: "Дополнительная информация"),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: "Цена"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
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
                  );
                  Navigator.pop(context, newFlavor);
                  print("новый вкус создан");
                } else {
                  print("не все поля заполнены");
                }
              },
              child: const Text("Сохранить"),
            )
          ],
        ),
      ),
    );
  }
}

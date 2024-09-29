import 'package:flutter/material.dart';
import 'package:pr4/components/list_item.dart';
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
    if (result != null && result.isNotEmpty) {
      setState(() {
        info.flavors.add(result);
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
                    ),
                    trailing: IconButton(
                        onPressed: () => _removeFlavor(index),
                        icon: const Icon(Icons.delete)),
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
  final TextEditingController _flavorController = TextEditingController();

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
              controller: _flavorController,
              decoration: const InputDecoration(labelText: "Введите название"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                String newFlavor = _flavorController.text;
                if (newFlavor.isNotEmpty) {
                  Navigator.pop(context, newFlavor);
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

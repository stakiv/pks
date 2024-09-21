import 'package:flutter/material.dart';
import 'package:pr3/components/list_item.dart';
import 'package:pr3/models/info.dart' as info;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: const Text(
          "Вкусы мороженого",
          style: TextStyle(
            color: Colors.black,
            fontSize: 21.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.amber[50],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
            itemCount: info.flavors.length,
            itemBuilder: (BuildContext context, int index) {
              return ListItem(
                  flavorName: info.flavors[index],
                  image: info.images[index],
                  description: info.desc[index],
                  price: info.prices[index],
                  feature: info.features[index]);
            }),
      ),
    );
  }
}

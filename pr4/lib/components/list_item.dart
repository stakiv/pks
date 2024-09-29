import 'package:flutter/material.dart';
import 'package:pr4/models/flavor.dart';
import 'package:pr4/pages/itam_page.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.flavor,
    required this.onDelete,
  });
  final Flavor flavor;
  final Function(Flavor) onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItamPage(
            flavorName: flavor.flavorName,
            image: flavor.image,
            description: flavor.description,
            price: flavor.price,
            feature: flavor.feature,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                  flavor.image,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          flavor.flavorName,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          flavor.description,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 65, 65, 65)),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Цена: ${flavor.price.toString()}",
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 65, 65, 65),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () => onDelete(flavor),
                    icon: const Icon(Icons.delete)),
              ],
            ),
            TextButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItamPage(
                          flavorName: flavor.flavorName,
                          image: flavor.image,
                          description: flavor.description,
                          price: flavor.price,
                          feature: flavor.feature,
                        ),
                      ),
                    ),
                child: const Text(
                  'Узнать больше',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(148, 133, 84, 1),
                      fontWeight: FontWeight.w500),
                ))
          ],
        ),
      ),
    );
  }
}

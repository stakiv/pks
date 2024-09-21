import 'package:flutter/material.dart';
import 'package:pr3/pages/itam_page.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {super.key,
      required this.flavorName,
      required this.image,
      required this.description,
      required this.price,
      required this.feature});
  final String flavorName;
  final String image;
  final String description;
  final int price;
  final String feature;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItamPage(
            flavorName: flavorName,
            image: image,
            description: description,
            price: price,
            feature: feature,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            //border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20.0)),
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                  image,
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
                          flavorName,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          description,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 65, 65, 65)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

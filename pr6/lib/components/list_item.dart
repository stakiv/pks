import 'package:flutter/material.dart';
import 'package:pr6/models/flavor.dart';
import 'package:pr6/models/info.dart';
import 'package:pr6/pages/itam_page.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.flavor,
    required this.onDelete,
    required this.onAdd,
    required this.onAddToCart,
  });
  final Flavor flavor;
  final Function(Flavor) onDelete;
  final Function(Flavor) onAdd;
  final Function(Flavor) onAddToCart;

  @override
  Widget build(BuildContext context) {
    bool isFavourite = favouriteFlavors.contains(flavor.id);
    bool isInCart = cartFlavors.contains(flavor.id);

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
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Column(
          children: [
            Image.network(
              flavor.image,
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    flavor.flavorName,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    flavor.description,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 65, 65, 65)),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Цена: ${flavor.price.toString()}",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 65, 65, 65),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 3.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isFavourite
                    ? IconButton(
                        onPressed: () => onAdd(flavor),
                        icon: const Icon(
                          Icons.favorite,
                          color: Color.fromRGBO(160, 149, 108, 1),
                        ))
                    : IconButton(
                        onPressed: () => onAdd(flavor),
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Color.fromRGBO(160, 149, 108, 1),
                        )),
                const SizedBox(
                  width: 20.0,
                ),
                isInCart
                    ? IconButton(
                        onPressed: () => onAddToCart(flavor),
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Color.fromRGBO(160, 149, 108, 1),
                        ))
                    : IconButton(
                        onPressed: () => onAddToCart(flavor),
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: Color.fromRGBO(160, 149, 108, 1),
                        )),
              ],
            ),
            const SizedBox(
              height: 3.0,
            ),
          ],
        ),
      ),
    );
  }
}

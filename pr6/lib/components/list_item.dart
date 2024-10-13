import 'package:flutter/material.dart';
import 'package:pr6/models/flavor.dart';
import 'package:pr6/models/info.dart';
import 'package:pr6/pages/itam_page.dart';

class ListItem extends StatefulWidget {
  const ListItem({
    super.key,
    required this.flavor,
    //required this.onDelete,
    required this.onAddToFavourites,
    required this.onAddToCart,
  });
  final Flavor flavor;
  //final Function(Flavor) onDelete;
  final Function(Flavor) onAddToFavourites;
  final Function(Flavor) onAddToCart;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    bool isFavourite = favouriteFlavors.contains(widget.flavor.id);
    bool isInCart = cartFlavors.contains(widget.flavor.id);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItamPage(
            flavor: widget.flavor,
            /*index: widget.flavor.id,
            flavorName: widget.flavor.flavorName,
            image: widget.flavor.image,
            description: widget.flavor.description,
            price: widget.flavor.price,
            feature: widget.flavor.feature*/
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
              widget.flavor.image,
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
                    widget.flavor.flavorName,
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
                    widget.flavor.description,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 65, 65, 65)),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Цена: ${widget.flavor.price.toString()}",
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
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (isFavourite) {
                        favouriteFlavors.remove(widget.flavor.id);
                      } else {
                        favouriteFlavors.add(widget.flavor.id);
                      }
                    });
                  },
                  icon: isFavourite
                      ? const Icon(Icons.favorite,
                          color: Color.fromRGBO(160, 149, 108, 1))
                      : const Icon(Icons.favorite_border,
                          color: Color.fromRGBO(160, 149, 108, 1)),
                ),
                const SizedBox(width: 20.0),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (isInCart) {
                        cartFlavors.remove(widget.flavor.id);
                      } else {
                        cartFlavors.add(widget.flavor.id);
                      }
                    });
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
          ],
        ),
      ),
    );
  }
}

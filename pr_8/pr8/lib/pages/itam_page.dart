import 'package:flutter/material.dart';
import 'package:pr8/models/api_service.dart';
import 'package:pr8/models/product_model.dart';

class ItamPage extends StatefulWidget {
  const ItamPage({
    super.key,
    required this.flavor,
    //required this.onAddToFavourites,
    //required this.onAddToCart,
  });
  final Product flavor;
  //final Function onAddToFavourites;
  //final Function onAddToCart;

  @override
  State<ItamPage> createState() => _ItamPageState();
}

class _ItamPageState extends State<ItamPage> {
  late Future<Product> flavors;
  late Future<Product> flavorsUpd;

  bool isFavourite = false;
  bool isInCart = false;

  int quantity = 0;

  @override
  void initState() {
    super.initState();
    flavors = ApiService().getProductById(widget.flavor.id);
    ApiService().getProductById(widget.flavor.id).then(
          (i) => {
            quantity = i.quantity,
            isFavourite = i.isFavourite,
            isInCart = i.isInCart
          },
        );
  }

  void updateItem(Product el) {
    Product newFlavors = Product(
        id: el.id,
        name: el.name,
        imageUrl: el.imageUrl,
        price: el.price,
        description: el.description,
        feature: el.feature,
        isFavourite: isFavourite,
        isInCart: isInCart,
        quantity: quantity);
    ApiService().changeProductStatus(newFlavors);
  }

  void _addToFavorites(Product i) {
    Product el = Product(
        id: i.id,
        name: i.name,
        imageUrl: i.imageUrl,
        price: i.price,
        description: i.description,
        feature: i.feature,
        isFavourite: !i.isFavourite,
        isInCart: i.isInCart,
        quantity: i.quantity);
    ApiService().changeProductStatus(el);
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  void addTOCart(Product i) async {
    Product el = Product(
        id: i.id,
        name: i.name,
        imageUrl: i.imageUrl,
        price: i.price,
        description: i.description,
        feature: i.feature,
        isFavourite: i.isFavourite,
        isInCart: !i.isInCart,
        quantity: !i.isInCart ? 1 : 0);
    ApiService().changeProductStatus(el);
    setState(() {
      isInCart = !isInCart;
      quantity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: flavors,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Вкусы не добавлены'));
        }

        final items = snapshot.data!;
        return Scaffold(
            backgroundColor: Colors.amber[50],
            appBar: AppBar(
              title: Text(
                widget.flavor.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 21.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0)),
              padding: const EdgeInsets.all(1),
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            _addToFavorites(items);
                          },
                          icon: isFavourite
                              ? const Icon(Icons.favorite,
                                  color: Color.fromRGBO(160, 149, 108, 1))
                              : const Icon(Icons.favorite_border,
                                  color: Color.fromRGBO(160, 149, 108, 1)),
                        ),
                        const SizedBox(width: 30.0),
                        IconButton(
                          onPressed: () {
                            addTOCart(items);
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
                    Image.network(
                      widget.flavor.imageUrl,
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
                        const SizedBox(
                          height: 35.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                //deleteItem(widget.flavor.id, context);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(204, 194, 153, 1),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 60.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                              child: const Text(
                                'Удалить',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}

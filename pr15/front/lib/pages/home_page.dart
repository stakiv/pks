import 'package:flutter/material.dart';
import 'package:front/models/cart_model.dart';
import 'package:front/pages/add_item_page.dart';
import 'package:front/pages/itam_page.dart';
import 'package:front/models/api_service.dart';
import 'package:front/models/product_model.dart';
import 'package:front/models/favourites_model.dart';
import 'package:front/models/user_model.dart';
import 'package:front/auth/auth_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Product>> _products;
  late List<Product> _productsUpd;
  late List<Cart> cartItems = [];
  late List<Favourites> favoriteItems = [];
  late List<Product> _filteredProducts = [];
  late Future<User> user;
  late int userId;

  String searchQuery = '';
  List<String> filterOptions = [
    "без сои",
    "без орехов",
    "без молочных продуктов",
    "без глютена",
    "без яиц"
  ];
  List<String> selectedFilters = [];
  List<String> sortOptions = [
    "по умолчанию",
    "дешевле",
    "дороже",
    "по алфавиту"
  ];
  String selectedSort = 'по умолчанию';

  @override
  void initState() {
    super.initState();
    _products = ApiService().getProducts();

    user = ApiService().getUserByEmail(AuthService().getCurrentUserEmail());
    user.then((currUser) {
      userId = currUser.id;
    });
    ApiService().getProducts().then((el) {
      setState(() {
        _productsUpd = el;
        _filteredProducts = el;
      });
    });
    _fetchFavorites();
    _fetchCart();
  }

  void _fetchFavorites() async {
    try {
      favoriteItems = await ApiService().getFavorites(userId);
      setState(() {});
    } catch (e) {
      print('Error fetching favorites: $e');
    }
  }

  void _fetchCart() async {
    try {
      cartItems = await ApiService().getCart(userId);
      setState(() {});
    } catch (e) {
      print('Error fetching cart: $e');
    }
  }

  void _setUpd() {
    setState(() {
      _products = ApiService().getProducts();
      _fetchFavorites();
      _fetchCart();
      ApiService().getProducts().then(
            (el) => {_productsUpd = el},
          );
    });
  }

  void _navigateToAddFlavorScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddFlavorScreen()),
    );
    _setUpd();
  }

  void _addToFavorites(Product i) async {
    await ApiService().addToFavorites(userId, i.id);
    _fetchFavorites();
    //setState(() {});
    _setUpd();
  }

  void _deleteFromFavourites(Product i) async {
    await ApiService().removeFromFavorites(userId, i.id);
    _fetchFavorites();
    //setState(() {});
    _setUpd();
  }

  void _deleteFromCart(Product i) async {
    await ApiService().removeFromCart(userId, i.id);
    _fetchCart();
    //setState(() {});
    _setUpd();
  }

  void addTOCart(Product i) async {
    int quantity = 1;
    await ApiService().addToCart(userId, i.id, quantity);
    _fetchCart();
    //setState(() {});
    _setUpd();
  }

  void _openItem(int id) async {
    final product = await ApiService().getProductById(id);
    int? answer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItamPage(
          flavor: product,
        ),
      ),
    );
    _setUpd();
  }

  void _openFilters() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              "Категории",
              style: TextStyle(fontSize: 16),
            ),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: ListBody(
                  children: filterOptions.map((category) {
                    return CheckboxListTile(
                      title: Text(
                        category,
                        style: const TextStyle(fontSize: 14),
                      ),
                      value: selectedFilters.contains(category),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedFilters.add(category);
                          } else {
                            selectedFilters.remove(category);
                          }
                          // Для отладки:
                          print(selectedFilters);
                        });
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Закрыть'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _filterByFeatures();
                for (int i = 0; i < selectedFilters.length; i++) {
                  print(selectedFilters[i]);
                }
              },
              child: Text('Применить'),
            ),
          ],
        );
      },
    );
  }

  void _openSort() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              "Сортировка",
              style: TextStyle(fontSize: 16),
            ),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: ListBody(
                  children: sortOptions.map((sort) {
                    return RadioListTile<String>(
                      title: Text(
                        sort,
                        style: const TextStyle(fontSize: 14),
                      ),
                      value: sort,
                      groupValue: selectedSort.isNotEmpty ? selectedSort : null,
                      onChanged: (String? value) {
                        setState(() {
                          if (value != null) {
                            selectedSort = value;
                          }

                          print(selectedFilters);
                        });
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Закрыть'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _sortProducts(selectedSort);

                print(selectedSort);
              },
              child: Text('Применить'),
            ),
          ],
        );
      },
    );
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _productsUpd;
      } else {
        _filteredProducts = _productsUpd.where((product) {
          final nameMatches =
              product.name.toLowerCase().contains(query.toLowerCase());
          final descriptionMatches =
              product.description.toLowerCase().contains(query.toLowerCase());
          return nameMatches || descriptionMatches;
        }).toList();
      }
    });
  }

  void _filterByFeatures() {
    print('_filterByFeatures got called');
    setState(() {
      if (selectedFilters.isEmpty) {
        print('список selectedFilters пустой');
        _filteredProducts = _productsUpd;
      } else {
        _filteredProducts = _productsUpd.where((product) {
          List<String> prodFeatures = product.feature
              .split(',')
              .map((feature) => feature.trim())
              .toList();
          return selectedFilters
              .every((filter) => prodFeatures.contains(filter));
        }).toList();
      }
      print('длина филтрованного списка: ${_filteredProducts.length}');
    });
  }

  void _sortProducts(String sortOpt) {
    setState(() {
      switch (sortOpt) {
        case "дешевле":
          _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
          break;
        case "дороже":
          _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
          break;
        case "по алфавиту":
          _filteredProducts.sort((a, b) => a.name.compareTo(b.name));
          break;
        case "по умолчанию":
          ApiService().getProducts().then((el) {
            setState(() {
              _productsUpd = el;
              _filteredProducts = el;
            });
          });
          break;
        default:
          break;
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
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 16.0, bottom: 0, left: 8, right: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      hintText: "Поиск по вкусам...",
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(160, 149, 108, 1),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(108, 98, 63, 1), width: 1),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13.0, horizontal: 13.0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        _filterProducts(searchQuery);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.sort),
                  onPressed: _openSort,
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: _openFilters,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: _products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Ошибка: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Вкусы не добавлены'));
                }

                final items = _filteredProducts;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.61,
                    //crossAxisSpacing: 10.0,
                    //mainAxisSpacing: 15.0
                  ),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final flavor = items[index];
                    bool isFavorite =
                        favoriteItems.any((product) => product.id == flavor.id);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => {_openItem(flavor.id)},
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: Column(
                            children: [
                              Image.network(
                                flavor.imageUrl,
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
                                      flavor.name,
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
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(255, 65, 65, 65)),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "Цена: ${flavor.price.toString()}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(255, 65, 65, 65),
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
                                      if (favoriteItems.any((product) =>
                                          product.productid == flavor.id)) {
                                        _deleteFromFavourites(flavor);
                                      } else {
                                        _addToFavorites(flavor);
                                      }
                                    },
                                    icon: favoriteItems.any((product) =>
                                            product.productid == flavor.id)
                                        ? const Icon(Icons.favorite,
                                            color: Color.fromRGBO(
                                                160, 149, 108, 1))
                                        : const Icon(Icons.favorite_border,
                                            color: Color.fromRGBO(
                                                160, 149, 108, 1)),
                                  ),
                                  const SizedBox(width: 20.0),
                                  IconButton(
                                    onPressed: () {
                                      if (cartItems.any((product) =>
                                          product.productid == flavor.id)) {
                                        _deleteFromCart(flavor);
                                      } else {
                                        addTOCart(flavor);
                                      }
                                    },
                                    icon: cartItems.any((product) =>
                                            product.productid == flavor.id)
                                        ? const Icon(Icons.shopping_cart,
                                            color: Color.fromRGBO(
                                                160, 149, 108, 1))
                                        : const Icon(Icons.add_shopping_cart,
                                            color: Color.fromRGBO(
                                                160, 149, 108, 1)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 3.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddFlavorScreen(context),
        tooltip: 'Добавить вкус',
        child: const Icon(Icons.add),
      ),
    );
  }
}

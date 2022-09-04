import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_proyect/Screens/AddDiscount.dart';
import 'package:first_proyect/Screens/AddProduct.dart';
import 'package:first_proyect/Screens/InfoStore.dart';
import 'package:first_proyect/Screens/createStore.dart';
import 'package:first_proyect/Screens/CalendarOffers.dart';
import 'package:first_proyect/Screens/SalesHistory.dart';
import 'package:first_proyect/model/Product.dart';
import 'package:first_proyect/model/Store.dart';
import 'package:first_proyect/model/UserApp.dart';
import 'package:first_proyect/model/productsData.dart';
import 'package:first_proyect/model/storeData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import '../Colors App/Constants.dart';
import 'Inventary.dart';
import 'Home.dart';
import 'Setting.dart';
import 'Profile.dart';
import 'StatisticsReport.dart';
import 'AddEmployeeCompany.dart';

import 'package:simple_speed_dial/simple_speed_dial.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  List<UserApp> user = [];
  String userEmailSelected;
  HomeScreen(this.user, this.userEmailSelected, {Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<Product> visibleProducts = [];

  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    readFirebase();
    _userNameAdmin = _showInfoAdmin(0);
    _userEmialAdmin = _showInfoAdmin(1);
    readLS();
    _screenSelected(1);
  }

  Future<void> readFirebase() async {
    final ref = FirebaseFirestore.instance
        .collection('tiendas')
        .doc(storeData.storeIDs.last)
        .withConverter<Store>(
            fromFirestore: (snapshots, _) => Store.fromJson2(snapshots.data()!),
            toFirestore: (store, _) => store.toJson());

    final docSnap = await ref.get();
    final store = docSnap.data();
    if (store != null) {
      setState(() {
        storeData.store.add(store);
        storeData.storeIDs.add(store.storeId);
        productsData.products.add(store.products);
        print(store);
      });
    } else {
      print("No leyó tiendas");
    }

    final data = await FirebaseFirestore.instance
        .collection('tiendas')
        .doc(storeData.storeIDs.last)
        .get();

    setState(() {
      if (storeData.storeIDs.isNotEmpty) {
        for (int i = 0; i < storeData.storeIDs.length; i++) {
          if (data['storeID'] as String != storeData.storeIDs[i]) {
            Store store = Store(
              data['storeID'] as String,
              data['storeName'] as String,
              data['storeAddress'] as String,
              data['storePhone'] as String,
              data['storeProducts'] as List<dynamic>,
            );
            storeData.store.add(store);
            storeData.storeIDs.add(store.storeId);
            print("Tienda: " + "$store");

            for (int i = 0; i < store.products.length; i++) {
              print("prod" + "${store.products[i].nameProduct}");
              productsData.products.add(store.products[i]);
            }
          } else if (data['storeID'] as String == storeData.storeIDs[i]) {
            List<dynamic> products = data['storeProducts'] as List<dynamic>;
            for (int i = 0; i < products.length; i++) {
              Product product = Product(
                products[i]['storeID'] as String,
                products[i]['nameProduct'] as String,
                products[i]['materialProduct'] as String,
                products[i]['descriptionProduct'] as String,
                products[i]['categoryProduct'] as int,
                products[i]['statusProduct'] as int,
                products[i]['imagePathProduct'] as String,
                products[i]['salePriceProduct'] as double,
                products[i]['productionPriceProduct'] as double,
                products[i]['quantityProducy'] as int,
                products[i]['minimumStock'] as int,
                products[i]['discountProduct'] as bool,
              );
              productsData.products.add(product);
            }
          }
        }
      } else {
        Store store = Store(
          data['storeID'] as String,
          data['storeName'] as String,
          data['storeAddress'] as String,
          data['storePhone'] as String,
          data['storeProducts'] as List<dynamic>,
        );
        storeData.store.add(store);
        storeData.storeIDs.add(store.storeId);
        print("Tienda: " + "$store");

        for (int i = 0; i < store.products.length; i++) {
          print("prod" + "${store.products[i].nameProduct}");
          productsData.products.add(store.products[i]);
        }
      }
    });

    final storesRef = await FirebaseFirestore.instance
        .collection('tiendas')
        .doc(storeData.storeIDs.last);
    ;

    storesRef.snapshots().listen((event) {
      Store store = event.data() as Store;

      print(store);

      print(store.storeName);

      storeData.store.add(store);
      storeData.storeIDs.add(store.storeId);

      for (int i = 0; i < store.products.length; i++) {
        print(store.products[i].nameProduct);
        productsData.products.add(store.products[i]);
      }

      /*var keys = doc.get('storeProducts').keys;
      var data = doc.get('storeProducts').values;

      for (var individualKey in keys) {
        Product product = Product(
          data[individualKey]['productId'],
          data[individualKey]['nameProduct'],
          data[individualKey]['materialProduct'],
          data[individualKey]['descriptionProduct'],
          data[individualKey]['categoryProduct'],
          data[individualKey]['stateProduct'],
          data[individualKey]['imagePathProduct'],
          data[individualKey]['salePriceProduct'],
          data[individualKey]['productionPriceProduct'],
          data[individualKey]['quantityProduct'],
          data[individualKey]['minimumStock'],
          data[individualKey]['isDiscounted'],
        );

        print(product.nameProduct);
        productsData.products.add(product);
      }

      print("arreglo:" + '${productsData.products}');

      visibleProducts = doc.get('storeProducts');
      productsData.products = visibleProducts;
      //print(data.entries);

      print("arreglo length: " + '${visibleProducts.length}');
      print("arreglo posicion 0: " + '${visibleProducts[0]}');
      */
    }, onError: (error) {
      print('Error: $error');
    });
  }

  Future<void> readLS() async {
    final items = await Localstore.instance.collection("products").get();
    for (var entry in items!.entries) {
      var product = Product.fromJson(entry.value);
      visibleProducts.add(product);
    }
  }

  String _userNameAdmin = "";
  String _userEmialAdmin = "";

  _screenSelected(int pos) {
    switch (pos) {
      case 1:
        return Home();
      case 0:
        return Inventary();
      case 2:
        return CalendarOffers();
    }
  }

  _showNamePage(int pos) {
    if (pos == 1) {
      return "Inicio";
    } else if (pos == 0) {
      return "Inventario";
    } else if (pos == 2) {
      return "Calendario de ofertas";
    }
  }

  String _showInfoAdmin(int prefer) {
    String name = "";
    String email = "";
    for (int i = 0; i < widget.user.length; i++) {
      if (widget.user[i].userEmail == widget.userEmailSelected) {
        if (prefer == 0) {
          name = widget.user[i].userName + " " + widget.user[i].userLastName;
          return name;
        } else if (prefer == 1) {
          email = widget.user[i].userEmail;
          return email;
        }
      }
    }
    return "";
  }

  IconButton _searchButton() {
    var search;
    if (currentPage == 0 || currentPage == 1) {
      return search = (IconButton(
        icon: const Icon(Icons.search),
        color: textColor,
        iconSize: 27,
        onPressed: () {},
      ));
    }
    return search;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          _showNamePage(currentPage),
          style: const TextStyle(
            color: textColor,
          ),
        ),
        elevation: 2,
        actions: <Widget>[
          if (currentPage == 0 || currentPage == 1) _searchButton(),
        ],
      ),
      drawer: Drawer(
        elevation: 50,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                _userNameAdmin,
                style: const TextStyle(
                  color: textColor,
                ),
              ),
              accountEmail: Text(
                _userEmialAdmin,
                style: const TextStyle(
                  color: textColor,
                ),
              ),
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: tertiaryColor,
                child: Text(
                  _userNameAdmin.characters.first,
                  style: const TextStyle(
                    fontSize: 40.0,
                    color: secundaryColor,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Ajustes'),
              leading: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Setting(widget.user, widget.userEmailSelected)),
                );
              },
            ),
            const Divider(
              color: Color.fromRGBO(158, 158, 158, 0.3),
              height: 5,
              thickness: 1.5,
              indent: 10,
              endIndent: 10,
            ),
            ListTile(
              title: const Text('Perfil'),
              leading: const Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Profile(widget.user, widget.userEmailSelected)),
                );
              },
            ),
            const Divider(
              color: Color.fromRGBO(158, 158, 158, 0.3),
              height: 5,
              thickness: 1.5,
              indent: 10,
              endIndent: 10,
            ),
            ListTile(
              title: const Text('Añadir empleado'),
              leading: const Icon(
                Icons.person_add_alt_sharp,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddEmployeeCompany()),
                );
              },
            ),
            const Divider(
              color: Color.fromRGBO(158, 158, 158, 0.3),
              height: 5,
              thickness: 1.5,
              indent: 10,
              endIndent: 10,
            ),
            ListTile(
              title: const Text('Información de la tienda'),
              leading: const Icon(
                Icons.history,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InfoStore()),
                );
              },
            ),
            const Divider(
              color: Color.fromRGBO(158, 158, 158, 0.3),
              height: 5,
              thickness: 1.5,
              indent: 10,
              endIndent: 10,
            ),
            ListTile(
              title: const Text('Informe y estadística'),
              leading: const Icon(
                Icons.bar_chart_rounded,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StatisticsReport()),
                );
              },
            ),
            const Divider(
              color: Color.fromRGBO(158, 158, 158, 0.3),
              height: 5,
              thickness: 1.5,
              indent: 10,
              endIndent: 10,
            ),
            ListTile(
              title: const Text('Historial de ventas'),
              leading: const Icon(
                Icons.history,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SalesHistory(visibleProducts)),
                );
              },
            ),
          ],
        ),
      ),
      body: _screenSelected(currentPage),

      //*Boton de navegación
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        iconSize: 35.0,
        backgroundColor: primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_outlined),
            label: 'Inventario',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendario',
            backgroundColor: Colors.black,
          ),
        ],
        currentIndex: currentPage,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.5),
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
      floatingActionButton: SpeedDial(
        child: const Icon(Icons.add),
        speedDialChildren: <SpeedDialChild>[
          SpeedDialChild(
            child: const Icon(Icons.add),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            label: 'Añade un producto',
            onPressed: () {
              if (storeData.store.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('No hay tiendas registradas'),
                      content: const Text(
                          'Para añadir un producto, primero debes registrar una tienda'),
                      actions: <Widget>[
                        CupertinoButton(
                          child: const Text(
                            'Volver',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddProduct(widget.user, widget.userEmailSelected)),
                );
              }
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.store),
            foregroundColor: Colors.black,
            backgroundColor: Colors.yellow,
            label: 'Añade una tienda',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CreateStore(widget.user, widget.userEmailSelected)),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.calendar_today),
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            label: 'Añade un descuento',
            onPressed: () {
              if (storeData.store.isEmpty) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('No hay tiendas registradas'),
                      content: const Text(
                          'Para añadir un descuento, primero debes registrar una tienda y añadir productos'),
                      actions: <Widget>[
                        CupertinoButton(
                          child: const Text(
                            'Volver',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddDiscount()),
                );
              }
            },
          ),
        ],
        closedForegroundColor: Colors.white,
        openForegroundColor: primaryColor,
        closedBackgroundColor: primaryColor,
        openBackgroundColor: Colors.white,
      ),
    );
  }
}

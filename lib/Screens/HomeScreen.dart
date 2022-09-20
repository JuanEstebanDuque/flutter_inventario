import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_proyect/Screens/AddDiscount.dart';
import 'package:first_proyect/Screens/AddProduct.dart';
import 'package:first_proyect/Screens/InfoStore.dart';
import 'package:first_proyect/Screens/createStore.dart';
import 'package:first_proyect/Screens/CalendarOffers.dart';
import 'package:first_proyect/Screens/SalesHistory.dart';
import 'package:first_proyect/main.dart';
import 'package:first_proyect/model/Product.dart';
import 'package:first_proyect/model/Store.dart';
import 'package:first_proyect/model/UserApp.dart';
import 'package:first_proyect/model/UserData.dart';
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
  HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<Product> visibleProducts = [];

  int currentPage = 1;

  //final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    readFirebase();
    readLS();
    _screenSelected(1);
  }

  Future<void> readFirebase() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('tiendas');

    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    /*for (var i = 0; i < allData.length; i++) {
      var store = Store.fromJson2(allData[i] as Map<String, dynamic>);
      storeData.store.add(store);
      storeData.storeIDs.add(store.storeId);
    }*/

    print(allData);

    CollectionReference _collectionRefProducts = FirebaseFirestore.instance
        .collection('tiendas')
        .doc('${storeData.storeIDs.last}')
        .collection('storeProducts');

    QuerySnapshot querySnapshotProducts = await _collectionRefProducts.get();
    final allDataProducts =
        querySnapshotProducts.docs.map((doc) => doc.data()).toList();

    /*for (var i = 0; i < allDataProducts.length; i++) {
      var product =
          Product.fromJson(allDataProducts[i] as Map<String, dynamic>);
      productsData.products.add(product);
    }*/

    print(allDataProducts);

    CollectionReference _collectionReferenceUser =
        FirebaseFirestore.instance.collection('Users');

    QuerySnapshot querySnapshotUser = await _collectionReferenceUser.get();
    final allDataUser =
        querySnapshotUser.docs.map((doc) => doc.data()).toList();

    print(allDataUser);
  }

  Future<void> readLS() async {
    final items = await Localstore.instance.collection("products").get();
    for (var entry in items!.entries) {
      var product = Product.fromJson(entry.value);
      visibleProducts.add(product);
    }
  }

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
          '',
          style: const TextStyle(
            color: textColor,
          ),
        ), //TODO: añadir dropdownbutton para las tiendas
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
                //user.displayName!
                '',
                style: const TextStyle(
                  color: textColor,
                ),
              ),
              accountEmail: Text(
                //user.email!
                '',
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
                  //user.displayName!.substring(0, 1)
                  '',
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
                    builder: (context) => Setting(),
                  ),
                );
                /*navigatorKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (context) => Setting(),
                  ),
                );*/
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
                    builder: (context) => Profile(),
                  ),
                );
                /*navigatorKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );*/
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
                    builder: (context) => AddEmployeeCompany(),
                  ),
                );
                /*navigatorKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (context) => AddEmployeeCompany(),
                  ),
                );*/
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
                  MaterialPageRoute(
                    builder: (context) => InfoStore(),
                  ),
                );
                /*navigatorKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (context) => InfoStore(),
                  ),
                );*/
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
                    builder: (context) => StatisticsReport(),
                  ),
                );
                /*navigatorKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (context) => StatisticsReport(),
                  ),
                );*/
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
                    builder: (context) => SalesHistory(visibleProducts),
                  ),
                );
                /*navigatorKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (context) => SalesHistory(visibleProducts),
                  ),
                );*/
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
                            //navigatorKey.currentState!.pop(context);
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
                    builder: (context) => AddProduct(),
                  ),
                );
                /*navigatorKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (context) => AddProduct(),
                  ),
                );*/
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
                  builder: (context) => CreateStore(),
                ),
              );
              /*navigatorKey.currentState!.push(
                MaterialPageRoute(
                  builder: (context) => CreateStore(),
                ),
              );*/
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
                            //navigatorKey.currentState!.pop(context);
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
                    builder: (context) => AddDiscount(),
                  ),
                );
                /*navigatorKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (context) => AddDiscount(),
                  ),
                );*/
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

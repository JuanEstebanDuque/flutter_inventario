//import 'dart:html';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_proyect/model/productsData.dart';
import 'package:first_proyect/model/storeData.dart';

import 'InfoProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:first_proyect/model/Product.dart';
import 'package:first_proyect/model/Status.dart';
import 'package:localstore/localstore.dart';

import 'package:first_proyect/model/ProductCategory.dart';
import 'package:first_proyect/Screens/AddProduct.dart';
import 'package:first_proyect/Colors App/Constants.dart';

enum Menu { Vender, Editar, Estadisticas, Eliminar }

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  void initState() {
    super.initState();
    _productsMinimumQuantity();
  }

  void _productsMinimumQuantity() {
    if (productsData.products.isNotEmpty) {
      for (int i = 0; i < productsData.products.length; i++) {
        if (productsData.products[i].quantityProduct <=
            productsData.products[i].minimunStock) {
          productsData.products.add(productsData.products[i]);
        }
      }
    }
  }

  var productSelected;

  Product _sendProductPage(int index) {
    var product;
    for (int i = 0; i < productsData.products.length; i++) {
      if (i == index) {
        product = productsData.products[i];
      }
    }
    return product;
  }

  bool selectedMinimumProducts() {
    bool selected = false;
    for (int i = 0; i < productsData.products.length; i++) {
      if (productsData.products[i].quantityProduct <=
          productsData.products[i].minimunStock) {
        selected = true;
      }
    }
    return selected;
  }

  @override
  Widget build(BuildContext context) {
    if (productsData.products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: const <Widget>[
                Icon(
                  Icons.warning,
                  color: Colors.grey,
                  size: 100,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'No hay productos mínimos disponibles.',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Center(
          child: Stack(
            children: <Widget>[
              /*Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 15),
                child: CupertinoSearchTextField(
                  autocorrect: true,
                  autofocus: false,
                  borderRadius: BorderRadius.circular(10),
                  placeholder: 'Buscar producto',
                  onChanged: searchProducts,
                ),
              ),*/
              const Padding(
                padding:
                    EdgeInsets.only(top: 25, left: 13, right: 13, bottom: 15),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Productos mínimos en tienda',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('tiendas')
                      .doc('${storeData.store.last}')
                      .collection('storeProducts')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 60, left: 12, right: 12),
                        child: SizedBox(
                          width: double.infinity,
                          height: 500,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 240,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 15,
                              childAspectRatio: 3 / 2,
                              mainAxisExtent: 185,
                            ),
                            itemCount: snapshot.data?.docs.length,
                            /*snapshot.data?.docs.where((element) {
                              return element.data()?['storeProducts'] != null;
                            }).length*/
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  productSelected = _sendProductPage(index);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InfoProduct(productSelected)),
                                  );
                                },
                                child: Card(
                                  elevation: 5,
                                  child: GridTile(
                                    child: Column(
                                      children: <Widget>[
                                        /*Image.asset(
                                  productsData.products[index].imagePathProduct,
                                  width: 195,
                                  height: 170,
                                  fit: BoxFit.fill,
                                ),*/
                                        Image.network(
                                          '${productsData.products[index].imagePathProduct}',
                                          width: 195,
                                          height: 170,
                                          fit: BoxFit.fill,
                                        ),
                                        Container(
                                          height: 62,
                                          padding: const EdgeInsets.only(
                                              top: 8, left: 9),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(0, 10),
                                                  blurRadius: 50,
                                                  color: primaryColor
                                                      .withOpacity(0.23),
                                                )
                                              ]),
                                          child: Column(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2),
                                                  child: Text(
                                                    '${productsData.products[index].nameProduct.toUpperCase()}',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4),
                                                  child: Text(
                                                    "Cantidad restante: ${productsData.products[index].quantityProduct}",
                                                    style: const TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        /*Padding(
                                  padding: const EdgeInsets.only(bottom: 30),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      visibleProductsMinimum[index].nameProduct,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 9),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      '${visibleProductsMinimum[index].quantityProduct}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: PopupMenuButton<Menu>(
                                    onSelected: (Menu result) {
                                      if (result == Menu.Vender) {
                                        /*Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AddProduct()),
                                );*/
                                      } else if (result == Menu.Editar) {
                                        /*Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AddProduct(productSelected)),
                                );*/
                                      } else if (result == Menu.Estadisticas) {
                                        /*Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AddProduct(productSelected)),
                                );*/
                                      } else if (result == Menu.Eliminar) {
                                        deleteProduct(index);
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<Menu>>[
                                      const PopupMenuItem<Menu>(
                                        value: Menu.Vender,
                                        child: Text(
                                          'Vender',
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                      const PopupMenuItem<Menu>(
                                        value: Menu.Editar,
                                        child: Text(
                                          'Editar',
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                      const PopupMenuItem<Menu>(
                                        value: Menu.Estadisticas,
                                        child: Text(
                                          'Estadisticas',
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                      const PopupMenuItem<Menu>(
                                        value: Menu.Eliminar,
                                        child: Text(
                                          'Eliminar',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),*/
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      );
    }
  }

  /// If the search bar is empty, show all products with quantity less than or equal to 10. If the
  /// search bar is not empty, show all products with quantity less than or equal to 10 that match the
  /// search query.
  /// </code>
  ///
  /// Args:
  ///   search (String): the text that the user is typing in the search bar
  ///
  /// Returns:
  ///   A list of products that have a quantity less than or equal to 10.

  void searchProducts(String search) {
    if (search != "") {
      final suggestion = productsData.products.where((prdct) {
        final productName = prdct.nameProduct.toLowerCase();
        final input = search.toLowerCase();
        return productName.contains(input);
      }).toList();
      setState(() => productsData.products = suggestion);
    } else {
      setState(() {
        productsData.products.clear();
        for (int i = 0; i < productsData.products.length; i++) {
          if (productsData.products[i].quantityProduct <= 10) {
            productsData.products.add(productsData.products[i]);
          }
        }
      });
    }
  }

  /// It deletes the product from the database and from the list of products
  ///
  /// Args:
  ///   product (int): the index of the product in the list

  void deleteProduct(int product) {
    setState(() {
      productsData.products.removeAt(product);
    });

    for (int i = 0; i < productsData.products.length; i++) {
      if (i == product) {
        print("entro");
        print(productsData.products[i].productId);
        Localstore.instance
            .collection("products")
            .doc(productsData.products[i].productId)
            .delete();
      }
    }
  }
}

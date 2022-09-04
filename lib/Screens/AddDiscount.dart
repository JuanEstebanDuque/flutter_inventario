import 'package:first_proyect/Screens/CalendarOffers.dart';
import 'package:first_proyect/Screens/Home.dart';
import 'package:first_proyect/Screens/HomeScreen.dart';
import 'package:first_proyect/model/DiscountProducts.dart';
import 'package:first_proyect/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';
import 'package:first_proyect/Colors App/Constants.dart';
import 'package:first_proyect/model/productsData.dart';

class AddDiscount extends StatefulWidget {
  //Receive the arrangement of products already read in 'HomeScreen'.
  AddDiscount({Key? key}) : super(key: key);
  @override
  State<AddDiscount> createState() => _AddDiscount();
}

class _AddDiscount extends State<AddDiscount> {
  String _discountName = "";

  DateTime _currentStartDay = DateTime.now();
  DateTime _currentEndDay = DateTime.now().add(const Duration(days: 1));

  List<Product> _discountedProducts = [];

  @override
  void initState() {
    super.initState();
    changeCheckedProducts();
  }

  void changeCheckedProducts() {
    for (int i = 0; i < productsData.products.length; i++) {
      if (productsData.products[i].isChecked) {
        productsData.products[i].isChecked = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Añadir descuento',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 25, right: 18, left: 18, bottom: 30),
          child: Center(
            child: Column(
              children: <Widget>[
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nombre del descuento.',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextField(
                    autofocus: false,
                    autocorrect: true,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ingrese parámetro',
                      hintStyle: TextStyle(
                        fontSize: 16,
                      ),
                      filled: true,
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _discountName = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Row(children: <Widget>[
                    const Text(
                      'Fecha de inicio: ',
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        '${_currentStartDay.day}/${_currentStartDay.month}/${_currentStartDay.year}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CupertinoButton(
                    child: const Text(
                      'Seleccione la fecha',
                      style: TextStyle(
                        fontSize: 17,
                        color: textButtonColor,
                      ),
                    ),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate:
                            DateTime.now().add(const Duration(days: 1825)),
                        confirmText: 'Aceptar',
                        cancelText: 'Cancelar',
                        helpText: 'Seleccione la fecha de inicialización',
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            _currentStartDay = date;
                          });
                        }
                      });
                    },
                    color: primaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Row(children: <Widget>[
                    const Text(
                      'Fecha de finalización: ',
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        '${_currentEndDay.day}/${_currentEndDay.month}/${_currentEndDay.year}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CupertinoButton(
                    child: Text(
                      'Seleccione la fecha',
                      style: TextStyle(
                        fontSize: 17,
                        color: textButtonColor,
                      ),
                    ),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate:
                            _currentStartDay.add(const Duration(days: 1)),
                        firstDate:
                            _currentStartDay.add(const Duration(days: 1)),
                        lastDate:
                            DateTime.now().add(const Duration(days: 1825)),
                        //fieldHintText: 'Fecha de finalización',
                        confirmText: 'Aceptar',
                        cancelText: 'Cancelar',
                        helpText: 'Seleccione la fecha de finalización',
                      ).then((date) {
                        if (date != null) {
                          setState(() {
                            _currentEndDay = date;
                          });
                        }
                      });
                    },
                    color: primaryColor,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Text(
                      'Seleccione los productos que tendrán el descuento',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productsData.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 7, right: 5, left: 5, bottom: 7),
                          child: Column(children: <Widget>[
                            CheckboxListTile(
                              activeColor: primaryColor,
                              dense: true,
                              title: Text(
                                productsData.products[index].nameProduct,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              value: productsData.products[index].isChecked,
                              secondary: SizedBox(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                  'Assets/_DAV9460-Editar.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              onChanged: (bool? value) {
                                setState(() {
                                  productsData.products[index].isChecked =
                                      value!;
                                });
                                if (productsData.products[index].isChecked) {
                                  _discountedProducts
                                      .add(productsData.products[index]);
                                } else {
                                  _discountedProducts
                                      .remove(productsData.products[index]);
                                }
                              },
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: CupertinoButton(
                    child: Text(
                      'Agregar descuento',
                      style: TextStyle(
                        fontSize: 17,
                        color: textButtonColor,
                      ),
                    ),
                    color: primaryColor,
                    onPressed: showAlertDiscount,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showAlertDiscount() {
    if (_discountName.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Error en el descuento',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            content: const Text(
              'El nombre del descuento no puede estar vacío',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text(
                  'Aceptar',
                  style: TextStyle(
                    fontSize: 16,
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
    } else if (_discountedProducts.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Error en el descuento',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            content: const Text(
              'Debe seleccionar al menos un producto',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text(
                  'Aceptar',
                  style: TextStyle(
                    fontSize: 16,
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
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Confirmación',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            content: const Text(
              '¿Está seguro de que desea agregar el descuento?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text(
                  'Aceptar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
                onPressed: () {
                  saveDiscount();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
              ),
              CupertinoDialogAction(
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    fontSize: 16,
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
    }
  }

  void saveDiscount() {
    String randomKey = const Uuid().v4();
    DiscountProduct discountProduct = DiscountProduct(randomKey,
        _currentStartDay, _currentEndDay, _discountName, _discountedProducts);
    Localstore.instance
        .collection("discounts")
        .doc(randomKey)
        .set(discountProduct.toJson());
  }
}

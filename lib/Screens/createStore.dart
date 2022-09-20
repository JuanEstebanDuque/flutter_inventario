import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_proyect/Screens/HomeScreen.dart';
import 'package:first_proyect/Screens/Login.dart';
import 'package:first_proyect/Screens/Register.dart';
import 'package:first_proyect/main.dart';
import 'package:first_proyect/model/Product.dart';
import 'package:first_proyect/model/Store.dart';
import 'package:first_proyect/model/UserApp.dart';
import 'package:first_proyect/model/productsData.dart';
import 'package:first_proyect/model/storeData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_proyect/Colors App/Constants.dart';
import 'package:localstore/localstore.dart';
import 'package:uuid/uuid.dart';

class CreateStore extends StatefulWidget {
  CreateStore({Key? key}) : super(key: key);
  @override
  State<CreateStore> createState() => _CreateStore();
}

class _CreateStore extends State<CreateStore> {
  String _storeID = Uuid().v4();
  String _storeName = "";
  String _storeAddress = "";
  String _storePhone = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*actions: [
          Image.asset(
            "Assets/AnarchyStoresLogo1.png",
            height: 40,
          ),
        ],*/
        title: const Text(
          'Crea tu tienda',
          style: TextStyle(
            color: textColor,
            fontFamily: 'ENGR',
          ),
        ),
        elevation: 2,
        backgroundColor: primaryColor,
      ),
      // ignore: prefer_const_constructors
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 10, right: 10, bottom: 20),
              child: Column(
                children: <Widget>[
                  /*const Text(
                    'Para crear una tienda debes completar todos los campos requeridos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),*/
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Para crear una tienda debes completar todos los campos requeridos. Para cada tienda la dirección debe ser única y para el teléfono puede ser el mismo para diferetes tiendas.',
                      style: TextStyle(
                        fontSize: 16,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'El ID de esta tienda es: \n $_storeID',
                        style: const TextStyle(
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: TextField(
                      autofocus: false,
                      autocorrect: true,
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        fillColor: Colors.grey[290],
                        filled: true,
                        hintText: 'Nombre de la tienda',
                      ),
                      onChanged: (String storeName) {
                        setState(() {
                          _storeName = storeName;
                        });
                        print(storeName);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: TextField(
                      autofocus: false,
                      autocorrect: true,
                      keyboardType: TextInputType.streetAddress,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        fillColor: Colors.grey[290],
                        filled: true,
                        hintText: 'Dirección de la tienda',
                      ),
                      onChanged: (String storeAddress) {
                        setState(() {
                          _storeAddress = storeAddress;
                        });
                        print(storeAddress);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: TextField(
                      autofocus: false,
                      autocorrect: true,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        fillColor: Colors.grey[290],
                        filled: true,
                        hintText: 'Teléfono de la tienda',
                      ),
                      onChanged: (String storePhone) {
                        setState(() {
                          _storePhone = storePhone;
                        });
                        print(storePhone);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, right: 15, left: 10, bottom: 20),
                    child: CupertinoButton(
                      color: primaryColor,
                      disabledColor: primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      pressedOpacity: 0.85,
                      onPressed: () {
                        if (verifyStore() == 2 || verifyStore() == 0) {
                          //Faltan campos por completar
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title:
                                    const Text('Faltan campos por completar'),
                                content: const Text(
                                    'Para crear una tienda debes completar todos los campos requeridos'),
                                actions: <Widget>[
                                  TextButton(
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
                        } else if (verifyStore() == -1) {
                          //Ya existe una tienda con la dirección registrada
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: const Text(
                                    'Ya existe una tienda con la dirección registrada'),
                                content: const Text(
                                    'Para crear una tienda las direcciones de las tiendas deben ser únicas'),
                                actions: <Widget>[
                                  TextButton(
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
                        } else if (verifyStore() == 1 || verifyStore() == 3) {
                          //La tienda se ha creado correctamente
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title:
                                    const Text('Tienda creada correctamente'),
                                content: const Text(
                                    'La tienda se ha creado correctamente'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text(
                                      'Continuar',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    onPressed: () {
                                      saveStore();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()),
                                          (route) => false);
                                      /*navigatorKey.currentState!
                                          .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen()),
                                              (Route<dynamic> route) => false);*/
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text(
                        'Crear tienda',
                        style: TextStyle(
                          color: textButtonColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  int verifyStore() {
    print('entreo veerity');
    print(_storeName);
    print(_storeAddress);
    print(_storePhone);
    if (_storeName != "" && _storeAddress != "" && _storePhone != "") {
      print("entro");
      if (storeData.store.isEmpty) {
        return 1;
      } else {
        for (int i = 0; i < storeData.store.length; i++) {
          print("entro a for");
          if (storeData.store[i].storeId != _storeID &&
              storeData.store[i].storeAddress != _storeAddress) {
            if (storeData.store[i].storePhone != _storePhone) {
              return 3;
            }
            return 1;
          } else {
            return -1;
          }
        }
      }
    } else {
      return 2;
    }
    return 0;
  }

  Future<void> saveStore() async {
    Store store = Store(
      _storeID,
      _storeName,
      _storeAddress,
      _storePhone,
      productsData.products,
    );
    storeData.store.add(store);
    Localstore.instance.collection('stores').doc(_storeID).set(
          store.toJson(),
        );

    FirebaseFirestore db = FirebaseFirestore.instance;

    storeData.storeIDs.add(_storeID);

    db.collection("tiendas").doc(_storeID).set({
      'storeID': _storeID,
      'storeName': _storeName,
      'storeAddress': _storeAddress,
      'storePhone': _storePhone,
      'storeProducts': productsData.products,
    });
  }
}

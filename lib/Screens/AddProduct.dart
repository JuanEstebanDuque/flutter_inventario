import 'dart:math';
import 'dart:ui';
import 'dart:io' as io;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_proyect/Screens/createStore.dart';

import 'package:first_proyect/model/productsData.dart';
import 'package:first_proyect/model/storeData.dart';

import 'HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:uuid/uuid.dart';
import '../model/Product.dart';
import '../model/UserApp.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'createStore.dart';

class AddProduct extends StatefulWidget {
  //Receive the arrangement of products already read in 'HomeScreen'.
  List<UserApp> users = [];
  String userSelected;
  AddProduct(this.users, this.userSelected, {Key? key}) : super(key: key);
  @override
  State<AddProduct> createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct> {
  var image;
  final picker = ImagePicker();
  String imagePath = "";

  Future selectionImage(int option) async {
    var pickedFile;
    if (option == 1) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        imagePath = image!.path;
      } else {
        showDialog<String>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Imagen no seleccionada'),
                content: const Text(
                    'Debe seleccionar una imagen para poder crear el producto.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Volver',
                      style: TextStyle(fontSize: 16.0, color: Colors.red),
                    ),
                  ),
                ],
              );
            });
      }
    });
    Navigator.of(context).pop();
  }

  //checklist to verify if the product to be added exists
  List<Product> checkProducts = [];

  //Necessary parameters for the DropdownButton of the product category
  var valueChooseCategory;
  List ListItemCategory = [
    'Anillo',
    'Pulsera',
    'Aretes',
    'Dijes',
    'Collares',
    'Sombreros'
  ];

  //Necessary parameters for the product status DropdownButton
  var valueChooseStatus;
  List ListItemStatus = ['Activo', 'Inactivo'];

  Color primaryColor = const Color.fromRGBO(240, 165, 0, 1);

  //Parameters required to create a product
  String _nameProduct = "";
  String _materialProduct = "";
  String _descriptionProduct = "";
  int _categoryProduct = 0;
  int _statusProduct = 0;
  double _salePriceProduct = 0;
  double _productionPriceProduct = 0;
  int _quantityProduct = 0;
  int _minimumStock = 0;
  bool _isDiscounted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Crear producto',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, top: 20.0, right: 20.0, bottom: 0.0),
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  autofocus: false,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: 'Nombre del producto',
                    hintStyle: const TextStyle(
                      fontSize: 14.3,
                    ),
                  ),
                  onChanged: (String nameProduct) {
                    setState(() {
                      _nameProduct = nameProduct;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    autofocus: false,
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: true,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Material del producto',
                      hintStyle: const TextStyle(
                        fontSize: 14.3,
                      ),
                    ),
                    onChanged: (String materialProduct) {
                      setState(() {
                        _materialProduct = materialProduct;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    autofocus: false,
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: true,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Descripción del producto',
                      hintStyle: const TextStyle(
                        fontSize: 14.3,
                      ),
                    ),
                    onChanged: (String descriptionProduct) {
                      setState(() {
                        _descriptionProduct = descriptionProduct;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 63,
                    alignment: Alignment.center,
                    child: DropdownButton(
                      hint: const Text("Seleccione una categoría del producto"),
                      value: valueChooseCategory,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      elevation: 16,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      isExpanded: true,
                      onChanged: (newValue) {
                        if (newValue == "Anillo") {
                          _categoryProduct = 1;
                        }
                        if (newValue == "Pulsera") {
                          _categoryProduct = 2;
                        }
                        if (newValue == "Aretes") {
                          _categoryProduct = 3;
                        }
                        if (newValue == "Dijes") {
                          _categoryProduct = 4;
                        }
                        if (newValue == "Collares") {
                          _categoryProduct = 5;
                        }
                        if (newValue == "Sombreros") {
                          _categoryProduct = 6;
                        }
                        setState(() {
                          valueChooseCategory = newValue;
                        });
                      },
                      items: ListItemCategory.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 63,
                    alignment: Alignment.center,
                    child: DropdownButton(
                      hint: const Text("Seleccione una estado del producto"),
                      value: valueChooseStatus,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 30,
                      elevation: 16,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      isExpanded: true,
                      onChanged: (newValue) {
                        if (newValue == "Activo") {
                          _statusProduct = 1;
                        }
                        if (newValue == "Inactivo") {
                          _statusProduct = 2;
                        }
                        setState(() {
                          valueChooseStatus = newValue;
                        });
                      },
                      items: ListItemStatus.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    autofocus: false,
                    autocorrect: true,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Precio de venta',
                      hintStyle: const TextStyle(
                        fontSize: 14.3,
                      ),
                    ),
                    onChanged: (String salePrice) {
                      setState(() {
                        _salePriceProduct = double.parse(salePrice);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    autofocus: false,
                    autocorrect: true,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Costo de producción',
                      hintStyle: const TextStyle(
                        fontSize: 14.3,
                      ),
                    ),
                    onChanged: (String productionPrice) {
                      setState(() {
                        _productionPriceProduct = double.parse(productionPrice);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    autofocus: false,
                    autocorrect: true,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Unidades restantes en tienda',
                      hintStyle: const TextStyle(
                        fontSize: 14.3,
                      ),
                    ),
                    onChanged: (String stock) {
                      setState(() {
                        _quantityProduct = int.parse(stock);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    autofocus: false,
                    autocorrect: true,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Unidad mínima requerida del producto',
                      hintStyle: const TextStyle(
                        fontSize: 14.3,
                      ),
                    ),
                    onChanged: (String minimumStock) {
                      setState(() {
                        _minimumStock = int.parse(minimumStock);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CupertinoButton(
                    disabledColor: const Color.fromRGBO(255, 152, 0, 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    pressedOpacity: 0.85,
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              contentPadding: const EdgeInsets.all(0),
                              content: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        selectionImage(1);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey))),
                                        child: Row(
                                          children: const [
                                            Expanded(
                                              child: Text(
                                                'Tomar foto',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            Icon(Icons.camera_alt,
                                                color: Color.fromRGBO(
                                                    240, 165, 0, 1))
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        selectionImage(2);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        child: Row(
                                          children: const [
                                            Expanded(
                                              child: Text(
                                                'Seleccionar foto',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            Icon(Icons.image,
                                                color: Color.fromRGBO(
                                                    240, 165, 0, 1))
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                        ),
                                        child: Row(
                                          children: const [
                                            Expanded(
                                              child: Text(
                                                'Cancelar',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: const Text(
                      'Seleccionar imagen',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: const Color.fromRGBO(240, 165, 0, 1),
                  ),
                ),
                if (image != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 250,
                      child:
                          image != null ? Image.file(image!) : const Center(),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 10.0, bottom: 20.0),
                  child: CupertinoButton(
                    disabledColor: const Color.fromRGBO(240, 165, 0, 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    pressedOpacity: 0.85,
                    onPressed: () {
                      if (checkRegisterProduct() == -1) {
                        showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                    'Creación de producto no exitosa'),
                                content: const Text(
                                    'Complete los parámetros y intente nuevamente.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Volver',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.red),
                                    ),
                                  ),
                                ],
                              );
                            });
                      } else if (checkRegisterProduct() == 0) {
                        showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                    'Creación de producto no exitosa'),
                                content: const Text(
                                    'El producto que desea crear ya existe. Cambie los parámetros para poder crear el producto.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Volver',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.red),
                                    ),
                                  ),
                                ],
                              );
                            });
                      } else if (checkRegisterProduct() == 1) {
                        saveProduct(1);
                        showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:
                                    const Text('Creación de producto exitosa'),
                                content: const Text(
                                    'Producto creado correctamente.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen(
                                                widget.users,
                                                widget.userSelected)),
                                      );
                                    },
                                    child: const Text(
                                      'Continuar',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.blue),
                                    ),
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    child: const Text(
                      'Crear producto',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: const Color.fromRGBO(240, 165, 0, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int checkRegisterProduct() {
    int verifyRegister = -1;
    if (_nameProduct != "" &&
        _materialProduct != "" &&
        _descriptionProduct != "" &&
        _categoryProduct != 0 &&
        _statusProduct != 0 &&
        _salePriceProduct != 0 &&
        _productionPriceProduct != 0 &&
        _quantityProduct != 0 &&
        _minimumStock != 0 &&
        image != null) {
      if (productsData.products.isNotEmpty) {
        for (int i = 0; i < productsData.products.length; i++) {
          if (_nameProduct == productsData.products[i].nameProduct) {
            verifyRegister = 0;
            return verifyRegister;
          }
        }
      }
      verifyRegister = 1;
      return verifyRegister;
    }
    return verifyRegister;
  }

  Future<void> saveProduct(int option) async {
    if (option == 1) {
      FirebaseFirestore db = FirebaseFirestore.instance;

      String randomKey = const Uuid().v4();

      var pathImage = "/$randomKey.jpg";

      final Reference ref = FirebaseStorage.instance.ref().child('products');
      final UploadTask uploadTask = ref.child(pathImage).putFile(image);
      var imageURL = await (await uploadTask.whenComplete(() => null))
          .ref
          .getDownloadURL();
      imagePath = imageURL.toString();
      print(imagePath);

      Product product = Product(
          randomKey,
          _nameProduct,
          _materialProduct,
          _descriptionProduct,
          _categoryProduct,
          _statusProduct,
          imageURL,
          _salePriceProduct,
          _productionPriceProduct,
          _quantityProduct,
          _minimumStock,
          _isDiscounted);
      Localstore.instance
          .collection("products")
          .doc(randomKey)
          .set(product.toJson());

      final prdct = <String, dynamic>{
        randomKey: product.toJson(),
      };

      String id = storeData.storeIDs.last;

      db.runTransaction((Transaction transaction) async {
        CollectionReference reference = db.collection('tiendas');
        reference.doc(id)
          ..update({
            'storeProducts': FieldValue.arrayUnion([prdct])
          });
        reference.doc(id).collection('storeProducts').add(prdct);
      });
    }
  }
}

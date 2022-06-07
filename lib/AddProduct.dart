import 'dart:math';
import 'dart:ui';

import 'package:first_proyect/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:uuid/uuid.dart';
import 'model/Product.dart';
import 'model/User.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddProduct extends StatefulWidget {
  //Receive the arrangement of products already read in 'HomeScreen'.
  List<Product> products = [];
  List<User> users = [];
  AddProduct(this.products,this.users,{ Key? key }) : super(key: key);
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  File? image = null;
  final picker = ImagePicker();

  Future selectionImage(int option) async{
    var pickedFile;
    if(option == 1){
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }else{
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      if(pickedFile != null){
        image = File(pickedFile.path);
      }else{
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
                  style: TextStyle(fontSize: 16.0,color: Colors.red),
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
    'Anillo','Pulsera','Aretes','Dijes','Collares','Sombreros'
  ];

  //Necessary parameters for the product status DropdownButton
  var valueChooseStatus;
  List ListItemStatus = [
    'Activo','Inactivo'
  ];

  //Parameters required to create a product
  String _nameProduct = "";
  String _materialProduct = "";
  String _descriptionProduct = "";
  int _categoryProduct = 0;
  int _statusProduct = 0;
  String _imagePathProduct = "";
  double _salePriceProduct =0;
  double _productionPriceProduct = 0;
  int _quantityProduct = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 152, 0, 1),
        title: const Text(
          'Crear producto',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 0.0),
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  autocorrect: true,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    //labelText: 'Nombre',
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: 'Nombre del producto',
                  ),
                  onChanged:  (String nameProduct) {
                    setState(() {
                      _nameProduct = nameProduct;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      //labelText: 'Nombre',
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Material del producto',
                    ),
                    onChanged:  (String materialProduct) {
                      setState(() {
                        _materialProduct = materialProduct;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      //labelText: 'Nombre',
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Descripción del producto',
                    ),
                    onChanged:  (String descriptionProduct) {
                      setState(() {
                        _descriptionProduct = descriptionProduct;
                      });
                    },
                  ),
                ),
                Padding(
                padding: const EdgeInsets.only(left: 0.0,top: 10.0,right: 0.0,bottom: 0.0), 
                child: Container(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 63,
                  alignment: Alignment.center,
                  child: DropdownButton(
                  hint: const Text("Seleccione una opción"),
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
                    if(newValue == "Anillo"){
                      _categoryProduct = 1;
                    }if(newValue == "Pulsera"){
                      _categoryProduct = 2;
                    }if(newValue == "Aretes"){
                      _categoryProduct = 3;
                    }if(newValue == "Dijes"){
                      _categoryProduct = 4;
                    }if(newValue == "Collares"){
                      _categoryProduct = 5;
                    }if(newValue == "Sombreros"){
                      _categoryProduct = 6;
                    }
                    setState(() {
                      valueChooseCategory = newValue; 
                    });
                  },
                  items: ListItemCategory.map((valueItem){
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                  ),
                ),
                ),
                Padding(
                padding: const EdgeInsets.only(left: 0.0,top: 10.0,right: 0.0,bottom: 0.0), 
                child: Container(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 63,
                  alignment: Alignment.center,
                  child: DropdownButton(
                  hint: const Text("Seleccione una opción"),
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
                    if(newValue == "Activo"){
                      _statusProduct = 1;
                    }if(newValue == "Inactivo"){
                      _statusProduct = 2;
                    }
                    setState(() {
                      valueChooseStatus = newValue; 
                    });
                  },
                  items: ListItemStatus.map((valueItem){
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
                    autofocus: true,
                    autocorrect: true,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      //labelText: 'Nombre',
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Precio de venta',
                    ),
                    onChanged:  (String descriptionProduct) {
                      setState(() {
                        _salePriceProduct = double.parse(descriptionProduct);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      //labelText: 'Nombre',
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Costo de producción',
                    ),
                    onChanged:  (String descriptionProduct) {
                      setState(() {
                        _productionPriceProduct = double.parse(descriptionProduct);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      //labelText: 'Nombre',
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Cantidad restante del producto',
                    ),
                    onChanged:  (String descriptionProduct) {
                      setState(() {
                        _quantityProduct = int.parse(descriptionProduct);
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
                    onPressed: (){
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
                                    onTap: (){
                                      selectionImage(1);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(width: 1, color: Colors.grey))
                                      ),
                                      child: Row(
                                        children: const [
                                          Expanded(
                                            child: Text(
                                              'Tomar foto',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Icon(Icons.camera_alt, color: Color.fromRGBO(255, 152, 0, 1))
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
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
                                          Icon(Icons.image, color: Color.fromRGBO(255, 152, 0, 1))
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
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
                                              style: TextStyle(fontSize: 16,color: Colors.white),
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
                    color: const Color.fromRGBO(255, 152, 0, 1),
                  ),
                ),
                if(image != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                      height: 300,
                      child: image != null ? Image.file(image!) : const Center(),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 15.0,bottom: 15.0),
                  child: CupertinoButton(
                    disabledColor: const Color.fromRGBO(255, 152, 0, 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    pressedOpacity: 0.85,
                    onPressed: (){
                      //Localstore.instance.collection("products").doc().delete();
                      if(checkRegisterProduct() == -1){
                        showDialog<String>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Creación de producto no exitosa'),
                              content: const Text(
                                'Complete los parámetros y intente nuevamente.'),
                              actions: <Widget>[
                                TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Volver',
                                  style: TextStyle(fontSize: 16.0,color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        });
                      }else if(checkRegisterProduct() == 0){
                        showDialog<String>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Creación de producto no exitosa'),
                              content: const Text(
                                'El producto que desea crear ya existe. Cambie los parámetros para poder crear el producto.'),
                              actions: <Widget>[
                                TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Volver',
                                  style: TextStyle(fontSize: 16.0,color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        });
                      }else if(checkRegisterProduct() == 1){
                        saveProduct(1);
                        showDialog<String>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Creación de producto exitosa'),
                              content: const Text(
                                'Producto creado correctamente.'),
                              actions: <Widget>[
                                TextButton(
                                onPressed: () {
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomeScreen(widget.users)),
                                  );
                                  },
                                  child: const Text(
                                    'Continuar',
                                  style: TextStyle(fontSize: 16.0,color: Colors.blue),
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
                    color: const Color.fromRGBO(255, 152, 0, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int checkRegisterProduct(){
    int verifyRegister = -1;
    if (_nameProduct!="" && _materialProduct!="" && _descriptionProduct!="" && _categoryProduct!=0 && _statusProduct!=0 && _salePriceProduct!=0 && _productionPriceProduct!=0 && _quantityProduct!=0) {
      if(widget.products.isNotEmpty){
        for (int i = 0; i < widget.products.length; i++) {
          if (_nameProduct == widget.products[i].nameProduct) {
            verifyRegister = 0;
          }
        } 
      }else{
        verifyRegister = 1;
      }
    } 
    return verifyRegister;
  }

  void saveProduct(int option){
    if(option == 1){
      String randomKey = const Uuid().v4();
      Product product = Product(randomKey, _nameProduct, _materialProduct, _descriptionProduct, _categoryProduct, _statusProduct, /*image!,*/ _salePriceProduct, _productionPriceProduct, _quantityProduct);
      Localstore.instance.collection("products").doc(randomKey).set(product.toJson());
      print("Guardé el producto!");
    }
  }

}
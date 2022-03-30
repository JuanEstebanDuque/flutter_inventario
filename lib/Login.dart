import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';
import 'package:localstore/localstore.dart';
import 'HomeScreen.dart';
import 'Register.dart';
import 'ForgotPassword.dart';
import 'model/Product.dart';
import 'model/ProductCategory.dart';
import 'model/Status.dart';
import 'model/StorageManager.dart';

class Login extends StatefulWidget{
  @override
  State<Login> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login>{


@override
  void initState() {
    super.initState();

    //Esta es la lista de productos general
    Map<String, Product> products = {
          "A":Product('Alfa', 'Plata 925', 'Precioso Anillo', ProductCategory.ring, Status.deactive, 4000, 1800, 5),
          "B":Product('Beta', 'Plata 925', 'Precioso Anillo', ProductCategory.ring, Status.deactive, 4000, 1800, 9),
          "G":Product('Gamma', 'Plata 925', 'Precioso Anillo', ProductCategory.ring, Status.active, 4000, 1800, 12),
          "D":Product('Delta', 'Plata 925', 'Precioso Anillo', ProductCategory.ring, Status.deactive, 4000, 1800, 15)
    };
    //String json = jsonEncode(products);

    for(var entry in products.entries){
      Localstore.instance.collection("products").doc(entry.key).set(entry.value.toJson());
    }

    Localstore.instance.collection("products").doc("list").delete();
    
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,top: 274.0,right: 20.0,bottom: 0.0),
          child: Column(
            children: <Widget>[
              const Text(
                'Iniciar Sesión',
                style: TextStyle(fontSize: 32),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5.0,top: 12.0,right: 5.0,bottom: 0.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Correo electrónico',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5.0,top: 10.0,right: 5.0,bottom: 0.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 0.0,bottom: 0.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                     padding: const EdgeInsets.only(left: 14.0,top: 0.0,right: 2.0,bottom: 0.0),
                     child: TextButton(
                       style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 14.0),
                  ),
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => Register()),
                      );
                      
                  },
                  child: const Text(
                      'Registrarse',
                      style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0,top: 0.0,right: 0.0,bottom: 0.0),
                    child: TextButton(
                     style: TextButton.styleFrom(
                       textStyle: const TextStyle(fontSize: 13.5),
                  ),
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                      );
                  },
                  child: const Text(
                      '¿Olvidó su contraseña?',
                      style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    ),
                  ],
                ), 
              ), 
              Padding(
                padding: const EdgeInsets.only(left: 0.0,top: 0.0,right: 0.0,bottom: 0.0),
                child: CupertinoButton(
                  disabledColor: const Color.fromRGBO(255, 152, 0, 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  pressedOpacity: 0.85,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: const Text(
                    'Iniciar sesión',
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
    );
  }
}
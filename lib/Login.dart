import 'dart:convert';

import 'package:first_proyect/model/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:localstore/localstore.dart';
import 'HomeScreen.dart';
import 'Register.dart';
import 'ForgotPassword.dart';
import 'model/Product.dart';
import 'model/ProductCategory.dart';
import 'model/Status.dart';
import 'model/User.dart';

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login>{
String _userEmail = "";
String _userPassword = "";

final List<User> saveUser = [];

@override
  void initState() {
    super.initState();
    readLS();
    /*if(saveUser.isEmpty){
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Register()),
        );
      });
    }*/
  }

  Future<void> readLS() async {
    final items = await Localstore.instance.collection('users').get();
    for(var entry in items!.entries){
      var user = User.fromJson(entry.value);
      saveUser.add(user);
      print(user.userRole);
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,top: 280.0,right: 20.0,bottom: 0.0),
            child: Column(
              children: <Widget>[
                const Text(
                  'Iniciar Sesión',
                  style: TextStyle(fontSize: 32),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0,top: 12.0,right: 5.0,bottom: 0.0),
                  child: TextField(
                    autofocus: true,
                    autocorrect: true,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      //labelText: 'Correo electrónico',
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Correo electrónico',
                    ),
                    onChanged: (String emailLogin){
                      setState(() {
                        _userEmail = emailLogin;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0,top: 10.0,right: 5.0,bottom: 0.0),
                  child: TextField(
                    autofocus: false,
                    autocorrect: true,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      //labelText: 'Contraseña',
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Contraseña',
                    ),
                    onChanged: (String passwordLogin){
                      setState(() {
                        _userPassword = passwordLogin;
                      });
                    },
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
                        MaterialPageRoute(builder: (context) => ForgotPassword(saveUser)),
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
                  padding: const EdgeInsets.only(left: 0.0,top: 0.0,right: 0.0,bottom: 15.0),
                  child: CupertinoButton(
                    disabledColor: const Color.fromRGBO(255, 152, 0, 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    pressedOpacity: 0.85,
                    onPressed: () {
                      if(verifyLogin() == 0){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen(saveUser)),
                        );
                      } else if (verifyLogin() == -1){
                        showDialog<String>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Inicio de sesión incorrecto'),
                            content: const Text(
                              'El correo o contraseña ingresados son incorrectos. Intente nuevamente.'),
                            actions: <Widget>[
                              TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Volver',
                              style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      });
                      }
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
      ),
    );
  }

  int verifyLogin(){
    int checkLogin = -1;
    for(int i=0;i<saveUser.length;i++){
      if(_userEmail == saveUser[i].userEmail && _userPassword == saveUser[i].userPassword){
        checkLogin = 0;
        return checkLogin;              
      } 
    }
    return checkLogin;
  }

}
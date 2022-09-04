import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_proyect/model/UserApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:localstore/localstore.dart';
import '../Colors App/Constants.dart';
import 'HomeScreen.dart';
import 'Register.dart';
import 'ForgotPassword.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginScreenState();
}

class loginData {
  static List<UserApp> saveUser = [];
}

class _LoginScreenState extends State<Login> {
  String _userEmail = "";
  String _userPassword = "";

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    readLS();
  }

  //UserApp? _userFromFirebase (User? user) => user == null ? null : UserApp(user.userCode, user.userName, user.userLastName, userApp.userId, userApp.userEmail, userApp.userPassword, userApp.userPhone, userApp.userSex, userApp.userRole, userApp.userCompany);

  Future<void> readLS() async {
    final items = await Localstore.instance.collection("users").get();
    print("entro a for de entries");
    for (var entry in items!.entries) {
      var user = UserApp.fromJson(entry.value);
      loginData.saveUser.add(user);
      print(loginData.saveUser[0].userEmail);
    }
  }

  //Stream<UserApp> get onAuthStateChanged => _firebaseAuth.authStateChanges().asyncMap(_userFromFirebase);

  /*Future<void> readLS2() async {
    await db.collection("Productos").get().then((event) {
      for (var doc in event.docs) {
      print("${doc.id} => ${doc.data()}");
      }
  });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, top: 135.0, right: 20.0, bottom: 0.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'Assets/AnarchyStoresLogo1.png',
                  width: 340,
                  height: 120,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, top: 12.0, right: 5.0, bottom: 0.0),
                  child: TextField(
                    autofocus: false,
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
                    onChanged: (String emailLogin) {
                      setState(() {
                        _userEmail = emailLogin;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, top: 10.0, right: 5.0, bottom: 0.0),
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
                    onChanged: (String passwordLogin) {
                      setState(() {
                        _userPassword = passwordLogin;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0.0, right: 2.0, top: 0.0, bottom: 0.0),
                  child: Center(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        children: <Widget>[
                          /*Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, top: 0.0, right: 2.0, bottom: 0.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 15.5),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()),
                                );
                              },
                              child: const Text(
                                'Registrarse',
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ),
                          ),*/
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 67.0, top: 0.0, right: 0.0, bottom: 0.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 15.5),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPassword(loginData.saveUser)),
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
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0.0, top: 0.0, right: 0.0, bottom: 15.0),
                  child: CupertinoButton(
                    disabledColor: primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    pressedOpacity: 0.85,
                    onPressed: () {
                      if (verifyLogin() == 0) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(loginData.saveUser, _userEmail)),
                            (Route<dynamic> route) => false);
                      } else if (verifyLogin() == -1) {
                        showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:
                                    const Text('Inicio de sesión incorrecto'),
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
                          color: textButtonColor,
                          //fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int verifyLogin() {
    int checkLogin = -1;
    print(loginData.saveUser.length);
    for (int i = 0; i < loginData.saveUser.length; i++) {
      print("entro for");
      if (_userEmail == loginData.saveUser[i].userEmail &&
          _userPassword == loginData.saveUser[i].userPassword) {
        checkLogin = 0;
        return checkLogin;
      }
    }
    print(checkLogin);
    return checkLogin;
  }
}

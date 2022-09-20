import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_proyect/main.dart';
import 'package:first_proyect/model/UserData.dart';

import 'Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

import '../model/UserApp.dart';

// ignore: must_be_immutable
class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);
  @override
  State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  @override
  void initState() {
    super.initState();
    readFirebase();
  }

  final user = FirebaseAuth.instance.currentUser!;

  Future<void> readFirebase() async {}

  String _password = "";
  String _passwordConfirm = "";

  Color primaryColor = const Color.fromRGBO(240, 165, 0, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Cambiar contraseña",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 120, left: 15, right: 15, bottom: 20),
            child: Column(
              children: <Widget>[
                const Text(
                  '¿Estás seguro que deseas cambiar la contraseña?',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15, left: 5, right: 5),
                  child: Text(
                    'Al cambiar la contraseña, la clave anterior se perderá para siempre.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 2.3, left: 5, right: 5),
                  child: Text(
                    'La nueva contraseña debe tener al menos 6 caracteres y contener al menos un número.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 15),
                  child: TextFormField(
                    autocorrect: true,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Cambiar contraseña',
                    ),
                    onChanged: (String password) {
                      setState(() {
                        _password = password;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_password) => _password != null &&
                            _password.length <
                                6 //TODO: Validar que sea diferente a la contraseña del usuario ya registrada
                        ? 'La contraseña debe tener al menos 6 caracteres'
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    autocorrect: true,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Confirmar contraseña',
                    ),
                    onChanged: (String passwordConfirm) {
                      setState(() {
                        _passwordConfirm = passwordConfirm;
                      });
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_passwordConfirm) => _passwordConfirm != null &&
                            _passwordConfirm != _password
                        ? 'Las contraseñas no coinciden'
                        : null,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: CupertinoButton(
                      child: const Text('Restaurar contraseña'),
                      disabledColor: const Color.fromRGBO(255, 152, 0, 1),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      pressedOpacity: 0.85,
                      onPressed: () {
                        if (verifyChangePassword() == 0) {
                          changePassword();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Restauración exitosa'),
                                content: const Text(
                                    'La contraseña ha sido restaurada con éxito.'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    child: const Text(
                                      'Aceptar',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));
                                      /*navigatorKey.currentState!.push(
                                        MaterialPageRoute(
                                          builder: (context) => const Login(),
                                        ),
                                      );*/
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (verifyChangePassword() == 1) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Restauración fallida'),
                                content: const Text(
                                    'La contraseñas ingresadas son diferentes. Reintente.'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    child: const Text(
                                      'Aceptar',
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
                        } else if (verifyChangePassword() == -1) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Restauración fallida'),
                                content: const Text(
                                    'La contraseña debe tener al menos 8 caracteres y contener al menos un número.'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    child: const Text(
                                      'Aceptar',
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Restauración fallida'),
                                content: const Text(
                                    'La nueva contraseña es igual a la registrada anteriormente.'),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    child: const Text(
                                      'Aceptar',
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
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int verifyChangePassword() {
    if (_password.length >= 6 && _password.contains(RegExp(r'[0-9]'))) {
      if (_password == _passwordConfirm) {
        return 0;
      } else {
        return 1;
      }
    } else if (_password.length < 6) {
      return -1;
    } else {
      for (int i = 0; i < UserData.users.length; i++) {
        if (UserData.users[i].userPassword == _password) {
          return 2;
        }
      }
    }
    return -2;
  }

  void changePassword() {
    String _userCode = "";
    String _userName = "";
    String _userLastName = "";
    String _userId = "";
    String _userEmail = "";
    String _userPassword = "";
    String _userPhone = "";
    int _userSex = 0;
    int _userRole = 0;
    String _userCompany = "";

    for (int i = 0; i < UserData.users.length; i++) {
      if (UserData.users[i].userEmail == user.email) {
        _userCode = UserData.users[i].userCode;
        _userName = UserData.users[i].userName;
        _userLastName = UserData.users[i].userLastName;
        _userId = UserData.users[i].userId;
        _userEmail = UserData.users[i].userEmail;
        _userPassword = _password;
        _userPhone = UserData.users[i].userPhone;
        _userSex = UserData.users[i].userSex;
        _userRole = UserData.users[i].userRole;
        break;
      }
    }

    for (int i = 0; i < UserData.users.length; i++) {
      if (UserData.users[i].userEmail == user.email) {
        Localstore.instance.collection("users").doc(_userId).delete();
        Map<String, UserApp> users = {
          _userCode: UserApp(_userCode, _userName, _userLastName, _userId,
              _userEmail, _userPassword, _userPhone, _userSex, _userRole)
        };
        for (var entry in users.entries) {
          Localstore.instance
              .collection("users")
              .doc(entry.key)
              .set(entry.value.toJson());
        }
        break;
      }
    }
  }
}

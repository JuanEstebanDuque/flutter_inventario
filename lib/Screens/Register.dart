import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_proyect/main.dart';
import 'package:first_proyect/model/UserData.dart';
import 'package:flutter/gestures.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../Colors App/Constants.dart';
import 'Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:uuid/uuid.dart';
import 'package:first_proyect/model/UserApp.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<Register> {
  var idFormatter = MaskTextInputFormatter(
      mask: '##########', filter: {"#": RegExp(r'[0-9]')});
  var phoneFormatter = MaskTextInputFormatter(
      mask: '##########', filter: {"#": RegExp(r'[0-9]')});

  final _firebaseAuth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  //Necessary parameters for the DropdownButton of the user roles
  List ListItem = ['Administrador', 'Colaborador', 'Empleado'];
  var valueChoose;

  List ListItem2 = ['Hombre', 'Mujer'];
  var valueChoose2;

  //Parameters required to create a user
  String _userName = "";
  String _userLastName = "";
  String _userId = "";
  String _userEmail = "";
  String _userPassword = "";
  String _checkPassword = "";
  String _userPhone = "";
  int _userSex = 0;
  int _optionRole = 0;

  @override
  void initState() {
    super.initState();
    readLS();
  }

  //Method that reads users that have already been created
  Future<void> readLS() async {
    final items = await Localstore.instance.collection('users').get();
    for (var entry in items!.entries) {
      var user = UserApp.fromJson(entry.value);
      UserData.users.add(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: const Text(
          'Registrarse',
          style: TextStyle(
            color: textColor,
            fontSize: 17,
            fontFamily: 'ENGR',
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            key: formKey,
            children: <Widget>[
              /*Image.asset(
                'Assets/AnarchyStoresLogo1.png',
                height: 100.0,
              ),*/
              const Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  'Para ingresar a la aplicación debe registrar todo los datos solicitados.',
                  style: TextStyle(fontSize: 18.0, color: textColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  autofocus: false,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: 'Nombre',
                  ),
                  onChanged: (String nameRegister) {
                    setState(() {
                      _userName = nameRegister;
                    });
                  },
                  autofillHints: const [AutofillHints.name],
                  /*autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_userName) =>
                      _userName != null ? 'Ingrese un nombre válido' : null,*/
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextFormField(
                  autofocus: false,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: 'Apellidos',
                  ),
                  onChanged: (String lastNameRegister) {
                    setState(() {
                      _userLastName = lastNameRegister;
                    });
                  },
                  autofillHints: const [AutofillHints.familyName],
                  /*autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_userLastName) => _userLastName != null
                      ? 'Ingrese un apellido válido'
                      : null,*/
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextFormField(
                  inputFormatters: [idFormatter],
                  autofocus: false,
                  autocorrect: true,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: 'Identificación',
                    prefixIcon: const Icon(
                      Icons.person,
                      color: secundaryColor,
                    ),
                  ),
                  onChanged: (String idRegister) {
                    setState(() {
                      _userId = idRegister;
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_userId) =>
                      _userId != null && _userId.length != 10
                          ? 'Ingrese una identificación válida'
                          : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextFormField(
                  autofocus: false,
                  autocorrect: true,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: 'Correo',
                    prefixIcon: const Icon(Icons.email, color: secundaryColor),
                  ),
                  onChanged: (String emailRegister) {
                    setState(() {
                      _userEmail = emailRegister;
                    });
                  },
                  autofillHints: const [AutofillHints.email],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_userEmail) =>
                      _userEmail != null && !EmailValidator.validate(_userEmail)
                          ? 'Ingrese un correo válido'
                          : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextFormField(
                  autocorrect: true,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: 'Contraseña',
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: secundaryColor,
                    ),
                  ),
                  onChanged: (String userPassword) {
                    setState(() {
                      _userPassword = userPassword;
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_userPassword) =>
                      _userPassword != null && _userPassword.length < 6
                          ? 'Ingrese una contraseña válida'
                          : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextFormField(
                  autofocus: false,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: 'Confimar contraseña',
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: secundaryColor,
                    ),
                  ),
                  onChanged: (String checkPasswordRegister) {
                    setState(() {
                      _checkPassword = checkPasswordRegister;
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_checkPassword) => _checkPassword != null &&
                          _checkPassword.length < 6 &&
                          _checkPassword != _userPassword
                      ? 'La contraseña no coincide'
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextFormField(
                  inputFormatters: [phoneFormatter],
                  autofocus: false,
                  autocorrect: true,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: 'Número de teléfono',
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: secundaryColor,
                    ),
                  ),
                  onChanged: (String numberRegister) {
                    setState(() {
                      _userPhone = numberRegister;
                    });
                  },
                  autofillHints: const [AutofillHints.telephoneNumber],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_userPhone) =>
                      _userPhone != null && _userPhone.length != 10
                          ? 'Ingrese un número de teléfono válido'
                          : null,
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
                    hint: const Text("Seleccione una género"),
                    value: valueChoose2,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 30,
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    isExpanded: true,
                    onChanged: (newValue) {
                      if (newValue == "Hombre") {
                        _userSex = 1;
                      }
                      if (newValue == "Mujer") {
                        _userSex = 2;
                      }
                      setState(() {
                        valueChoose2 = newValue;
                      });
                    },
                    items: ListItem2.map((valueItem) {
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
                    hint: const Text("Seleccione una rol"),
                    value: valueChoose,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 30,
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                    isExpanded: true,
                    onChanged: (newValue) {
                      if (newValue == "Administrador") {
                        _optionRole = 1;
                      }
                      if (newValue == "Colaborador") {
                        _optionRole = 2;
                      }
                      if (newValue == "Empleado") {
                        _optionRole = 3;
                      }
                      setState(() {
                        valueChoose = newValue;
                      });
                    },
                    items: ListItem.map((valueItem) {
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
                    left: 0.0, top: 15.0, right: 0.0, bottom: 10.0),
                child: CupertinoButton(
                    disabledColor: primaryColor,
                    color: primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    pressedOpacity: 0.5,
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(
                        color: textButtonColor,
                      ),
                    ),
                    onPressed: () {
                      if (checkRegister() == 1) {
                        showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Registro exitoso'),
                                content: const Text(
                                    'Su usuario fue registrado correctamente.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      signUp();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                          (Route<dynamic> route) => false);
                                      /*navigatorKey.currentState!
                                          .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Login()),
                                              (Route<dynamic> route) => false);*/
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
                      } else if (checkRegister() == 2) {
                        showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Registro no exitoso'),
                                content: const Text(
                                    'Las contraseñas ingresadas no coinciden, verifique e intente nuevamente.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      //navigatorKey.currentState!.pop(context);
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
                      } else if (checkRegister() == 0) {
                        showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Registro no exitoso'),
                                content: const Text(
                                    'El correo ingresado ya existe. Intente nuevamente.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      //navigatorKey.currentState!.pop(context);
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
                      } else if (checkRegister() == -1) {
                        showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Registro no exitoso'),
                                content: const Text(
                                    'Complete los parámetros para poder registrarse. Intente nuevamente.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      //navigatorKey.currentState!.pop(context);
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
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int checkRegister() {
    int verifyRegister = -1;
    if (_userName != "" &&
        _userLastName != "" &&
        _userId != "" &&
        _userEmail != "" &&
        _userPassword != "" &&
        _userPassword.length >= 6 &&
        _checkPassword != "" &&
        _checkPassword.length >= 6 &&
        _userPhone != "" &&
        _userSex != 0 &&
        _optionRole != 0) {
      if (UserData.users.isNotEmpty) {
        for (int i = 0; i < UserData.users.length; i++) {
          if (_userEmail == UserData.users[i].userEmail) {
            verifyRegister = 0;
            return verifyRegister;
          }
        }
      }
      if (_userPassword == _checkPassword) {
        print("Registro exitoso");
        String randomKey = Uuid().v4();
        Map<String, UserApp> users = {
          randomKey: UserApp(randomKey, _userName, _userLastName, _userId,
              _userEmail, _userPassword, _userPhone, _userSex, _optionRole),
        };
        for (var entry in users.entries) {
          Localstore.instance
              .collection("users")
              .doc(randomKey)
              .set(entry.value.toJson());
          print("se guardo");

          FirebaseFirestore db = FirebaseFirestore.instance;

          final Reference ref = FirebaseStorage.instance.ref().child('Users');

          UserApp user = UserApp(randomKey, _userName, _userLastName, _userId,
              _userEmail, _userPassword, _userPhone, _optionRole, _userSex);

          UserData.users.add(user);

          final usr = <String, dynamic>{randomKey: user.toJson()};

          db.runTransaction((Transaction transaction) async {
            CollectionReference reference = db.collection('Users');
            await reference.add(usr);
          });

          //Localstore.instance.collection("users").doc().delete();
        }
        verifyRegister = 1;
        return verifyRegister;
      } else {
        verifyRegister = 2;
        return verifyRegister;
      }
    }
    return verifyRegister;
  }

  Future<void> signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _userEmail.toString().trim(),
          password: _userPassword.toString().trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}

import 'Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/User.dart';
import 'package:localstore/localstore.dart';
import 'package:uuid/uuid.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<Register> {
  String _userName = "";
  String _userLastName = "";
  String _userEmail = "";
  String _userPassword = "";
  String _checkPassword = "";
  String _userPhone = "";
  String _userCompany = "";

  final List<User> checkUser = [];

  @override
  void initState() {
    super.initState();
    readLS();
  }

  Future<void> readLS() async {
    final items = await Localstore.instance.collection('users').get();
    for (var entry in items!.entries) {
      var user = User.fromJson(entry.value);
      checkUser.add(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 152, 0, 1),
        title: const Text(
          'Registrarte',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, top: 20.0, right: 20.0, bottom: 0.0),
          child: Column(
            children: <Widget>[
              TextField(
                autofocus: true,
                autocorrect: true,
                keyboardType: TextInputType.name,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre',
                ),
                onSubmitted:  (String nameRegister) {
                  setState(() {
                    _userName = nameRegister;
                    //print(_userName);
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  autofocus: true,
                  autocorrect: true,
                  keyboardType: TextInputType.name,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Apellido',
                  ),
                  onSubmitted: (String lastNameRegister) {
                    setState(() {
                      _userLastName = lastNameRegister;
                      //print(_userLastName);
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  autofocus: true,
                  autocorrect: true,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Correo',
                  ),
                  onSubmitted: (String emailRegister) {
                    setState(() {
                      _userEmail = emailRegister;
                      //print(_userEmail);
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0,top: 10.0,right: 0.0,bottom: 0.0), 
                child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                  ),
                  onSubmitted: (String userPassword){
                    setState(() {
                      _userPassword = userPassword;
                    });
                    
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  autofocus: true,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirmar contraseña',
                  ),
                  onSubmitted: (String checkPasswordRegister) {
                    setState(() {
                      _checkPassword = checkPasswordRegister;
                      //print(_checkPassword);
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  autofocus: true,
                  autocorrect: true,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Número de celular',
                  ),
                  onSubmitted: (String numberRegister) {
                    setState(() {
                      _userPhone = numberRegister;
                      //print(_userPhone);
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  autofocus: true,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre de la empresa',
                  ),
                  onSubmitted: (String companyRegister) {
                    setState(() {
                      _userCompany = companyRegister;
                      //print(_userCompany);
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 15.0, right: 0.0, bottom: 0.0),
                child: CupertinoButton(
                    disabledColor: const Color.fromRGBO(255, 152, 0, 1),
                    color: const Color.fromRGBO(255, 152, 0, 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    pressedOpacity: 0.5,
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_userName != "" && _userLastName != "" && _userEmail != "" && _userPassword != "" && _checkPassword == "" && _userPhone != "" && _userCompany != "") {
                        if(_userPassword == _checkPassword){
                          String randomKey = Uuid().v4();
                          Map<String, User> users = {
                            randomKey: User(_userName, _userLastName, _userEmail,_userPassword, _userPhone, 1),
                          };
                          for (var entry in users.entries) {
                            //Localstore.instance.collection("users").doc(entry.key).set(entry.value.toJson());
                            Localstore.instance.collection("users").doc(entry.key).delete();
                          }
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
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => Login()),
                                      );
                                    },
                                    child: const Text('Continuar'),
                                  ),
                                ],
                              );
                            });
                        }
                      } else if (checkUser != []) {
                        for (int i = 0; i < checkUser.length; i++) {
                          if (_userEmail == checkUser[i].userEmail) {
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
                        }
                      } else {
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
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

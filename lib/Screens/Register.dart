import 'package:flutter/gestures.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_proyect/model/User.dart';
import 'package:localstore/localstore.dart';
import 'package:uuid/uuid.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<Register> {
  var idFormatter = MaskTextInputFormatter(mask: '##########', filter: { "#": RegExp(r'[0-9]') });
  var phoneFormatter = MaskTextInputFormatter(mask: '##########', filter: { "#": RegExp(r'[0-9]') });


  //Necessary parameters for the DropdownButton of the user roles
  List ListItem = [
    'Administrador','Colaborador','Empleado'
  ];
  var valueChoose;

  List ListItem2 = [
    'Hombre','Mujer'
  ];
  var valueChoose2;

  //User arrangement to check if the user to be created already exists
  final List<User> checkUser = [];

  //Parameters required to create a user
  String _userName = "";
  String _userLastName = "";
  String _userId = "";
  String _userEmail = "";
  String _userPassword = "";
  String _checkPassword = "";
  String _userPhone = "";
  String _userCompany = "";
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
                onChanged:  (String nameRegister) {
                  setState(() {
                    _userName = nameRegister;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
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
                    hintText: 'Apellidos',
                  ),
                  onChanged: (String lastNameRegister) {
                    setState(() {
                      _userLastName = lastNameRegister;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
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
                  ),
                  onChanged: (String idRegister) {
                    setState(() {
                      _userId = idRegister;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  autofocus: false,
                  autocorrect: true,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: 'Correo',
                  ),
                  onChanged: (String emailRegister) {
                    setState(() {
                      _userEmail = emailRegister;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0,top: 10.0,right: 0.0,bottom: 0.0), 
                child: TextField(
                  autocorrect: true,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: 'Contraseña',
                  ),
                  onChanged: (String userPassword){
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
                  autofocus: false,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: 'Confimar contraseña',
                  ),
                  onChanged: (String checkPasswordRegister) {
                    setState(() {
                      _checkPassword = checkPasswordRegister;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
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
                  ),
                  onChanged: (String numberRegister) {
                    setState(() {
                      _userPhone = numberRegister;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  autofocus: false,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: 'Nombre de la empresa'
                  ),
                  onChanged: (String companyRegister) {
                    setState(() {
                      _userCompany = companyRegister;
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
                    if(newValue == "Hombre"){
                        _userSex = 1;
                      }if(newValue == "Mujer"){
                        _userSex = 2;
                      }
                    setState(() {
                      valueChoose2 = newValue; 
                    });
                  },
                  items: ListItem2.map((valueItem){
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
                    if(newValue == "Administrador"){
                        _optionRole = 1;
                      }if(newValue == "Colaborador"){
                        _optionRole = 2;
                      }if(newValue == "Empleado"){
                        _optionRole = 3;
                      }
                    setState(() {
                      valueChoose = newValue; 
                    });
                  },
                  items: ListItem.map((valueItem){
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
                    disabledColor: const Color.fromRGBO(255, 152, 0, 1),
                    color: const Color.fromRGBO(255, 152, 0, 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    pressedOpacity: 0.5,
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if(checkRegister() == 1){
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
                                  MaterialPageRoute(builder: (context) => const Login()),
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
                      } else if(checkRegister() == 2){
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
                                  },
                                  child: const Text(
                                    'Volver',
                                  style: TextStyle(fontSize: 16.0,color: Colors.red),
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
                              },
                              child: const Text(
                                'Volver',
                              style: TextStyle(fontSize: 16.0,color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      });  
                      } else if(checkRegister() == -1){
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
                              style: TextStyle(fontSize: 16.0,color: Colors.red),
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

  
  int checkRegister(){
    int verifyRegister = -1;
    if (_userName!="" && _userLastName!="" && _userId!="" && _userEmail!="" && _userPassword!="" && _userPassword.length>=6 && _checkPassword!="" && _checkPassword.length>=6 && _userPhone!="" && _userCompany!="" && _userSex!=0 && _optionRole!=0) {
      if(checkUser.isNotEmpty){
        for (int i = 0; i < checkUser.length; i++) {
          if (_userEmail == checkUser[i].userEmail) {
            verifyRegister = 0;
            return verifyRegister;                    
          }
        }
      }
      if(_userPassword == _checkPassword){
        String randomKey = Uuid().v4();
        Map<String, User> users = {
          randomKey: User(randomKey,_userName, _userLastName, _userId, _userEmail,_userPassword, _userPhone, _userSex, _optionRole, _userCompany),
        };
        for (var entry in users.entries) {
        Localstore.instance.collection("users").doc(entry.key).set(entry.value.toJson());
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
}
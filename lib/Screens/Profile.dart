import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_proyect/model/UserData.dart';
import 'package:first_proyect/model/UserData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:first_proyect/model/UserApp.dart';
import 'package:first_proyect/Colors App/Constants.dart';

import '../main.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  var idFormatter = MaskTextInputFormatter(
      mask: '##########', filter: {"#": RegExp(r'[0-9]')});
  var phoneFormatter = MaskTextInputFormatter(
      mask: '##########', filter: {"#": RegExp(r'[0-9]')});

  int profileSelected = -1;
  Color primaryColor = const Color.fromRGBO(240, 165, 0, 1);

  String _userName = "";
  String _userLastName = "";
  String _userPhone = "";
  String _sexProfile = "";
  String _roleProfile = "";

  @override
  void initState() {
    super.initState();
    profileSelected = profileParameters();
    sexProfile();
    roleProfile();
  }

  final user = FirebaseAuth.instance.currentUser!;

  int profileParameters() {
    int profile = -1;
    for (int i = 0; i < UserData.users.length; i++) {
      if (UserData.users[i].userEmail == user.email) {
        profile = i;
      }
    }
    return profile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Perfil',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 15.0, left: 16, right: 13, bottom: 20.0),
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Mi usuario.',
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    'Actualiza tus datos personales.',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Nombre',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
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
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: UserData.users[profileSelected].userName,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  onChanged: (String nameRegister) {
                    setState(() {
                      _userName = nameRegister;
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_userName) => _userName !=
                          null //TODO: Verificar cuando se lean los usuarios de firebase que el nuevo nombre no sea el mismo
                      ? 'El nombre no puede estar vacío'
                      : null,
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Apellidos',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
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
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: UserData.users[profileSelected].userLastName,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  onChanged: (String lastNameRegister) {
                    setState(() {
                      _userLastName = lastNameRegister;
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_userLastName) => _userLastName !=
                          null //TODO: Verificar cuando se lean los usuarios de firebase que el nuevo apellido no sea el mismo
                      ? 'El apellido no puede estar vacío'
                      : null,
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Número de identificación',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: UserData.users[profileSelected].userId,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Correo electrónico',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: UserData.users[profileSelected].userEmail,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.red,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[900],
                    ),
                  ),
                  onChanged: (String emailRegister) {},
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Teléfono',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
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
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: UserData.users[profileSelected].userPhone,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  onChanged: (String phoneRegister) {
                    setState(() {
                      _userPhone = phoneRegister;
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_userPhone) => _userPhone != null &&
                          _userPhone.length !=
                              10 //TODO: Verificar cuando se lean los usuarios de firebase que el nuevo teléfono no sea el mismo
                      ? 'El teléfono no puede estar vacío'
                      : null,
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Sexo',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: _sexProfile,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.red,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[900],
                    ),
                  ),
                  onChanged: (String sexRegister) {},
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Rol',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: _roleProfile,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.red,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[900],
                    ),
                  ),
                  onChanged: (String rolRegister) {},
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Empresa',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ), //0.8212
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CupertinoButton(
                  color: primaryColor,
                  disabledColor: primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  pressedOpacity: 0.85,
                  onPressed: () {
                    Navigator.of(context).pop();
                    //navigatorKey.currentState!.pop(context);
                  },
                  child: const Text(
                    'Guardar cambios',
                    style: TextStyle(
                      color: textButtonColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              //Guardar cambios en la nube o datos locales y luego leer en homeScreen
            ],
          ),
        ),
      ),
    );
  }

  void sexProfile() {
    if (UserData.users[profileSelected].userSex == 1) {
      _sexProfile = "Hombre";
    } else if (UserData.users[profileSelected].userSex == 2) {
      _sexProfile = "Mujer";
    }
  }

  void roleProfile() {
    if (UserData.users[profileSelected].userRole == 1) {
      _roleProfile = "Administrador";
    } else if (UserData.users[profileSelected].userRole == 2) {
      _roleProfile = "Colaborador";
    } else if (UserData.users[profileSelected].userRole == 3) {
      _roleProfile = "Empleado";
    }
  }
}

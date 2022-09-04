import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:first_proyect/model/Product.dart';
import 'package:first_proyect/model/UserApp.dart';
import 'package:first_proyect/Colors App/Constants.dart';

class ForgotPassword extends StatefulWidget {
  List<UserApp> user = [];
  ForgotPassword(this.user, {Key? key}) : super(key: key);
  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  String _inputUserEmail = "";
  String _checkUserEmail = "";

  String userEmail() {
    String email = "";

    return email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Recuperar contraseña',
          style: TextStyle(
            color: textColor,
            fontSize: 13,
            fontFamily: 'ENGR',
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, top: 60.0, right: 20.0, bottom: 0.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'Assets/AnarchyStoresLogo1.png',
                  width: 330,
                  height: 130,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Ingrese el correo electrónico vinculado a la cuenta para recibir la restauración de la contraseña.',
                      style: TextStyle(color: textColor, fontSize: 18),
                      //textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0.0, top: 15.0, right: 0.0, bottom: 15.0),
                  child: TextField(
                    autofocus: false,
                    autocorrect: true,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    style: const TextStyle(fontSize: 17),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      //labelText: 'Correo electrónico',
                      fillColor: Colors.grey[290],
                      filled: true,
                      hintText: 'Correo electrónico',
                      hintStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.grey[700],
                      ),
                    ),
                    onChanged: (String emailRecoverPassword) {
                      setState(() {
                        _inputUserEmail = emailRecoverPassword;
                      });
                    },
                  ),
                ),
                CupertinoButton(
                  disabledColor: primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  pressedOpacity: 0.85,
                  child: Text(
                    'Reestablecer',
                    style: TextStyle(
                      color: textButtonColor,
                    ),
                  ),
                  color: primaryColor,
                  onPressed: () => showDialog<String>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Restauración de contraseña'),
                          content: const Text(
                              '¿Seguro desea mandar la restauración de contraseña a este correo?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancelar',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              },
                              child: const Text('Continuar'),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

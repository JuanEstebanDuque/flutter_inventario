import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Login.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 152, 0, 1),
        title: const Text(
          'Recuperar contraseña',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
              const EdgeInsets.only(left: 20.0, top: 250.0, right: 20.0, bottom: 0.0),
            child: Column(
              children: <Widget>[
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Ingrese el correo electrónico vinculado a la cuenta para recibir la restauración de la contraseña.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                    ),
                    //textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 0.0, top: 15.0, right: 0.0, bottom: 15.0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Correo electrónico',
                    ),
                  ),
                ),
                CupertinoButton(
                    disabledColor: const Color.fromRGBO(255, 152, 0, 1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    pressedOpacity: 0.85,
                    child: const Text(
                      'Reestablecer',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: const Color.fromRGBO(255, 152, 0, 1),
                    onPressed: () => showDialog<String>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Restauración de contraseña'),
                          content: const Text('¿Seguro desea mandar la restauración de contraseña a este correo?'),
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
                                  MaterialPageRoute(builder: (context) => Login()),
                                );
                              },
                              child: const Text('Continuar'),
                            ),
                          ],
                        );
                      } 
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

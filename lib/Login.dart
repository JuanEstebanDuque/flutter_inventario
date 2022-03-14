import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'HomeScreen.dart';

class Login extends StatefulWidget{
  @override
  State<Login> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login>{
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,top: 275.0,right: 20.0,bottom: 0.0),
          child: Column(
            children: <Widget>[
              const Text(
                'Iniciar Sesión',
                style: TextStyle(fontSize: 32),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5.0,top: 10.0,right: 5.0,bottom: 0.0),
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
                padding: const EdgeInsets.only(left: 0.0,top: 0.0,right: 0.0,bottom: 0.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 13.0),
                    onSurface: Colors.grey,
                    //backgroundColor: Colors.blue,
                  ),
                  onPressed: null,
                  child: const Text('¿Olvidó su contraseña?'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0,top: 0.0,right: 0.0,bottom: 0.0),
                child: CupertinoButton.filled(
                  disabledColor: Colors.blue,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
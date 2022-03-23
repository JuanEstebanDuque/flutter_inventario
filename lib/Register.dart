import 'Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Register extends StatefulWidget{
  @override
  State<Register> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<Register>{
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
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0,bottom: 0.0),
          child: Column(
            children: <Widget>[
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(), 
                  labelText: 'Nombre',
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 0.0,top: 10.0,right: 0.0,bottom: 0.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(), 
                    labelText: 'Apellido',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 0.0,top: 10.0,right: 0.0,bottom: 0.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(), 
                    labelText: 'Correo',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 0.0,top: 10.0,right: 0.0,bottom: 0.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(), 
                    labelText: 'Contraseña',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 0.0,top: 10.0,right: 0.0,bottom: 0.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(), 
                    labelText: 'Confirmar contraseña',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 0.0,top: 10.0,right: 0.0,bottom: 0.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Número de celular', 
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 0.0,top: 10.0,right: 0.0,bottom: 0.0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre de la empresa', 
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0,top: 15.0,right: 0.0,bottom: 0.0),
                child: CupertinoButton(
                  disabledColor: const Color.fromRGBO(255, 152, 0, 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  pressedOpacity: 0.5,
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(color: Colors.white),
                  ), 
                  onPressed: () => showDialog<String>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Registro exitoso'),
                        content: const Text('Su usuario fue registrado correctamente.'),
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
                    } 
                  ),
                  color: const Color.fromRGBO(255, 152, 0, 1),
                  ),
              ),
            ],
          ),
        ),
    );
  }
}
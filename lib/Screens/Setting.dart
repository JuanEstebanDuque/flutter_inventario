import 'Login.dart';
import 'package:first_proyect/Screens/ManageUsers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

import 'ChangePassword.dart';
import 'package:first_proyect/model/User.dart';

class Setting extends StatefulWidget{
  List<User> user = [];
  String userEmailSelected;
  Setting(this.user,this.userEmailSelected, {Key? key}):super(key: key);
  @override
  State<Setting> createState() => _Setting();
}

class _Setting extends State<Setting>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 152, 0, 1),
        title: const Text(
          'Ajustes',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0,left: 5,right: 5,bottom: 10.0),
          child: Column(
            children: <Widget> [
              ListTile(
                title: const Text('Cambiar contraseña'),
                leading: const Icon(Icons.lock,
                  color: Colors.black,
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePassword(widget.user,widget.userEmailSelected)),
                  );
                },
              ),
              const Divider(
                color: Color.fromRGBO(158, 158, 158, 0.3),
                height: 5,
                thickness: 1.5,
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                title: const Text('Administrar usuarios'),
                leading: const Icon(Icons.people,
                  color: Colors.black,
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManageUsers(widget.user)),
                  );
                },
              ),
              const Divider(
                color: Color.fromRGBO(158, 158, 158, 0.3),
                height: 5,
                thickness: 1.5,
                indent: 10,
                endIndent: 10,
              ),

              Align(
                alignment: Alignment.bottomLeft,
                child: ListTile(
                  title: const Text(
                    'Cerrar sesión',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  leading: const Icon(Icons.exit_to_app,
                    color: Colors.red,
                  ),
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Cerrar sesión'),
                          content: const Text('¿Está seguro que desea cerrar sesión?'),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: const Text(
                                'Aceptar',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              onPressed: () {
                                exitUserToApp();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Login()),
                                );
                              },
                            ),
                            CupertinoDialogAction(
                              child: const Text(
                                'Volver',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void exitUserToApp() {
    for (int i=0; i < widget.user.length; i++) {
      if (widget.user[i].userEmail == widget.userEmailSelected) {
        Localstore.instance.collection("users").doc(widget.user[i].userId).delete();
      }
    }
  }

}
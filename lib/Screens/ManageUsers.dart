import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/User.dart';

class ManageUsers extends StatefulWidget {
  List<User> user = [];
  ManageUsers(this.user,{Key? key}) : super(key: key);
  @override
  State<ManageUsers> createState() => _ManageUsers();
}

class _ManageUsers extends State<ManageUsers>{

  Color primaryColor = const Color.fromRGBO(255, 152, 0, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Administrar usuarios',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:first_proyect/Screens/Login.dart';
import 'package:first_proyect/Screens/StartingApp.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = false;

  @override
  Widget build(BuildContext context) => !isLogin ? Login() : StartingApp();

  void toggleView() {
    setState(() {
      isLogin = !isLogin;
    });
  }
}

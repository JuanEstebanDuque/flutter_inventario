import 'package:flutter/material.dart';

class Setting extends StatefulWidget{
  const Setting({Key? key}):super(key: key);
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
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}
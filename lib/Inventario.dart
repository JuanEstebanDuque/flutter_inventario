import 'package:flutter/material.dart';

class Inventario extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Inventario',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
    );
  }
}
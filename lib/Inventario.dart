import 'package:flutter/material.dart';

class Inventario extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 20.0,
        width: 20.0,
        color: Colors.black,
        child: const Text(
          'Inventario',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
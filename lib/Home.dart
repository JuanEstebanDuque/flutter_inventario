import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Center(
      child: Container(
        width: 20.0,
        height: 20.0,
        color: Colors.black,
        child: const Text(
          'Inicio',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
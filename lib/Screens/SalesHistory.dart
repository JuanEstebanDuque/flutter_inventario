import 'package:first_proyect/model/Product.dart';
import 'package:flutter/material.dart';

class SalesHistory extends StatefulWidget{
  List<Product> productsSold = [];
  SalesHistory(this.productsSold,{Key? key}):super(key: key);
  @override
  State<SalesHistory> createState() => _SalesHistory();
}

class _SalesHistory extends State<SalesHistory> {

  Color primaryColor = const Color.fromRGBO(255, 152, 0, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de ventas'),
        backgroundColor: primaryColor,
      ),
    );
  }
}
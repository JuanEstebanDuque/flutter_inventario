import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'model/Product.dart';

class Inventario extends StatefulWidget{
   @override
    State<Inventario> createState() => _Inventario();
}

class _Inventario extends State<Inventario> {



  @override
  void initState() {
    super.initState();
    readLS();
  }

  Future<void> readLS() async {
    final items = await Localstore.instance.collection('products').get();
    for(var entry in items!.entries){
      var product = Product.fromJson(entry.value);
      print(product.nameProduct);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
          'Inventario',
          style: TextStyle(color: Colors.black,fontSize: 20),
        ),
    );
  }
}



  
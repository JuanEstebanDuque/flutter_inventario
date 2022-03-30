//import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:first_proyect/model/Product.dart';
import 'package:first_proyect/model/Status.dart';
import 'package:localstore/localstore.dart';

import 'model/ProductCategory.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {

  //Esta es la lista de productos visibles en pantalla
  final List<Product> visibleProducts = [];

  //Este es el método al que me refiero que es como el initializable de JavaFX
  @override
  void initState() {
    super.initState();
    readLS();
  }

   Future<void> readLS() async {
    final items = await Localstore.instance.collection('products').get();
    for(var entry in items!.entries){
      var product = Product.fromJson(entry.value);
      if(product.quantityProduct <= 10){
        setState(() {
          visibleProducts.add(product);  
        });
        
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        padding: const EdgeInsets.only(left: 12, top: 10, right: 8, bottom: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: visibleProducts.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: GridTile(
              footer: Text(visibleProducts[index].name),
              child: Image.asset(
                'Anillo/_DAV9460-Editar.png',
                width: 100,
              ),
            ),
            elevation: 5,
          );
        },
      ),
    );
  }
}

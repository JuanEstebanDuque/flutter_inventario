//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:first_proyect/model/Product.dart';
import 'package:first_proyect/model/ProductData.dart';
import 'package:first_proyect/model/Category.dart';
import 'package:first_proyect/model/Status.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    ProductData data2 = ProductData();
    Product data = Product('Barón Rojo', 'Plata 925', 'Precioso Anillo', Category.ring,Status.deactive, 4000, 1800, 9);
    ProductData().product.add(Product('Shini', 'Plata 925', 'Precioso Anillo', Category.ring, Status.deactive, 4000, 1800, 20));

    List<Product> screenProduct = [];
    setState(() {
      for (int i = 0; i < ProductData().product.length; i++) {
        if (ProductData().product[i].quantityProduct <= 10) {
          screenProduct[i] = ProductData().product[i];
          
        }
      }
    });

    return Center(
      child: GridView.builder(
        padding: const EdgeInsets.only(left: 12, top: 10, right: 8, bottom: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: screenProduct.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: GridTile(
              footer: Text(screenProduct[index].name),
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

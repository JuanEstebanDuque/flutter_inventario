//import 'dart:html';

import 'package:first_proyect/InfoProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:first_proyect/model/Product.dart';
import 'package:first_proyect/model/Status.dart';
import 'package:localstore/localstore.dart';

import 'model/ProductCategory.dart';
import 'AddProduct.dart';

class Home extends StatefulWidget {
  List<Product> products = [];
  Home(this.products, {Key? key}):super(key: key);
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  List<Product> visibleProductsMinimum = [];

  @override
  void initState() {
    super.initState();
    _productsMinimumQuantity();
    /*if(visibleProductsMinimum.isEmpty){
      return Center(
        child: Text(
          'Añada productos',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      );
    }*/
  }

  void _productsMinimumQuantity(){
    for(int i=0;i<widget.products.length;i++){
      if(widget.products[i].quantityProduct < 10){
        visibleProductsMinimum.add(widget.products[i]);
      }
    }
  }  

  var productSelected;

  String _productToLookFor = "";

  Product _sendProductPage(int index) {
    var product;
    for (int i = 0; i < visibleProductsMinimum.length; i++) {
      if (i == index) {
        product = visibleProductsMinimum[i];
      }
    }
    return product;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 15),
            child: CupertinoSearchTextField(
              autocorrect: true,
              autofocus: true,
              borderRadius: BorderRadius.circular(10),
              placeholder: 'Buscar producto',
              onChanged: searchProducts,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 65,left: 12,right: 8,bottom: 10),
            child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemCount: visibleProductsMinimum.length,
            itemBuilder: (BuildContext context, int index) {
              String price = "${visibleProductsMinimum[index].salePriceProduct}";
              return GestureDetector(
                onTap: (){
                  productSelected = _sendProductPage(index);
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => InfoProduct(productSelected)),
                  );
                },
                child: Card(
                child: GridTile(
                  header: Text(
                    visibleProductsMinimum[index].nameProduct,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.5,
                    ),
                  ),
                  footer: Text(
                    price,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  child: Image.asset(
                    'Anillo/_DAV9460-Editar.png',
                    width: 100,
                  ),
                ),
                elevation: 5,
              ),
              );
            },
            ),
          ),
        ]
      ),
    );
  }

  void searchProducts (String search) {
    final suggestion = visibleProductsMinimum.where((prdct) {
      final productName = prdct.nameProduct.toLowerCase();
      final input = search.toLowerCase();
      return productName.contains(input);
    }).toList();

    setState(() => visibleProductsMinimum = suggestion);
  }


  } 


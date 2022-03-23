//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:first_proyect/model/Product.dart';
import 'package:first_proyect/model/ProductData.dart';


class Home extends StatelessWidget{

  List<Products> product = [
    Products('Barón rojo', 'Plata 925', 'Hermoso', 2500, 2000, 20),
    Products('King Dead', 'Plata 925', 'Feo', 3500, 1500, 15),
    Products('Silver Skull', 'Plata 925 y Baño de oro de 18K', 'Imponente', 2850, 1900, 10),
    Products('Silver Skull', 'Plata 925 y Baño de oro de 18K', 'Imponente', 2850, 1900, 10),
    Products('Silver Skull', 'Plata 925 y Baño de oro de 18K', 'Imponente', 2850, 1900, 10),
    Products('Silver Skull', 'Plata 925 y Baño de oro de 18K', 'Imponente', 2850, 1900, 10),
    Products('Silver Skull', 'Plata 925 y Baño de oro de 18K', 'Imponente', 2850, 1900, 10),
    Products('Silver Skull', 'Plata 925 y Baño de oro de 18K', 'Imponente', 2850, 1900, 10),
    Products('Silver Skull', 'Plata 925 y Baño de oro de 18K', 'Imponente', 2850, 1900, 10),
    Products('Silver Skull', 'Plata 925 y Baño de oro de 18K', 'Imponente', 2850, 1900, 10),
    Products('Silver Skull', 'Plata 925 y Baño de oro de 18K', 'Imponente', 2850, 1900, 10),
  ];

  @override
  Widget build(BuildContext context){
    return Center(
      child: GridView.builder(
        padding: const EdgeInsets.only(left: 12,top: 10,right: 8,bottom: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: product.length,
        itemBuilder: (BuildContext context,int index) {
          return Card(
              child: GridTile(
                footer: Text(product[index]._name),
                child: Image.asset('Anillo/_DAV9460-Editar.png', width: 100,),
              ),
              elevation: 5,
            );
          /*if(ProductData().product[index].quantityProduct == 10){
            
          }else if(ProductData().product == null){
            return Text(
              'No se han añadido productos.',
              style: TextStyle(fontSize: 10.0),
            );
          }*/
        },        
      ),
    );
  }
}

class Products{
  //attributes
  String _name = '';
  String _material = '';
  String _description = '';
  //Category _category = Category.newest;
  //Status _status = Status.deactive;
  double _salePrice = 0;
  double _productionPrice = 0;
  int _quantityProduct = 0;

  //relations

  //methods
  Products(String name,String material,String description,/*Category category,Status status,*/double salePrice,double productionPrice,int quantityProduct){
    _name = name;
    _material = material;
    _description = description;
    //_category = category;
    //_status = status;
    _salePrice = salePrice;
    _productionPrice = productionPrice;
    _quantityProduct = quantityProduct;
  }
}


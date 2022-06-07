import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'model/Product.dart';
import 'InfoProduct.dart';
import 'AddProduct.dart';

class Inventary extends StatefulWidget{
  List<Product> products = [];
  Inventary(this.products, {Key? key}):super(key: key);
  @override
  State<Inventary> createState() => _Inventary();
}

class _Inventary extends State<Inventary> {
  List<Product> visibleProducts = [];

  @override
  void initState() {
    super.initState();
    _addProductToArray();
  }

  void _addProductToArray(){
    for(int i=0;i<widget.products.length;i++){
      visibleProducts.add(widget.products[i]);
    }
  }

  var productSelected;

  Product _sendProductPage(int index) {
    var product;
    for (int i = 0; i < visibleProducts.length; i++) {
      if (i == index) {
        product = visibleProducts[i];
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
            padding: const EdgeInsets.only(left: 12, top: 65, right: 8, bottom: 10),
            child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemCount: visibleProducts.length,
            itemBuilder: (BuildContext context, int index) {
              String price = "${visibleProducts[index].salePriceProduct}";
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
                    visibleProducts[index].nameProduct,
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
    final suggestion = visibleProducts.where((Product){
      return Product.nameProduct.toLowerCase().contains(search.toLowerCase());
    }).toList();
    setState(() {
      visibleProducts = suggestion;
    });
  }

}



  
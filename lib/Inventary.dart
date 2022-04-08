import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'model/Product.dart';
import 'InfoProduct.dart';

class Inventario extends StatefulWidget{
   @override
    State<Inventario> createState() => _Inventario();
}

class _Inventario extends State<Inventario> {
  final List<Product> visibleProducts = [];

  @override
  void initState() {
    super.initState();
    readLS();
  }

  Future<void> readLS() async {
    final items = await Localstore.instance.collection('products').get();
    for(var entry in items!.entries){
      var product = Product.fromJson(entry.value);
      visibleProducts.add(product);
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
      child: GridView.builder(
        padding: const EdgeInsets.only(left: 12, top: 10, right: 8, bottom: 10),
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
    );
  }
}



  
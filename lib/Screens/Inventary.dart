import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:first_proyect/model/Product.dart';
import 'InfoProduct.dart';
import 'package:first_proyect/Screens/AddProduct.dart';

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
              mainAxisExtent: 230,
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
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Image.asset(
                          'Assets/_DAV9460-Editar.png',
                          width: 210,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 3),
                        child: Text(
                          visibleProducts[index].nameProduct,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(
                          price,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
  if(search != ""){
      final suggestion = visibleProducts.where((prdct) {
        final productName = prdct.nameProduct.toLowerCase();
        final input = search.toLowerCase();
        return productName.contains(input);
      }).toList();
      setState(() => visibleProducts = suggestion);
    } else {
      setState((){
        visibleProducts.clear();
        for (int i = 0; i < widget.products.length; i++) {
          visibleProducts.add(widget.products[i]);
        }
      });
    }
  }

}


  
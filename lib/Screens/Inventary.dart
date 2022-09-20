import 'package:first_proyect/Colors%20App/Constants.dart';
import 'package:first_proyect/main.dart';
import 'package:first_proyect/model/ProductCategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:first_proyect/model/Product.dart';
import 'InfoProduct.dart';
import 'package:first_proyect/Screens/AddProduct.dart';
import 'package:first_proyect/model/productsData.dart';

enum Menu { Vender, Editar, Estadisticas, Eliminar }

class Inventary extends StatefulWidget {
  Inventary({Key? key}) : super(key: key);
  @override
  State<Inventary> createState() => _Inventary();
}

class _Inventary extends State<Inventary> {
  List<Product> visibleProducts = [];

  List<FilterChipData> filterChips = [
    FilterChipData('Aretes', false),
    FilterChipData('Anillos', false),
    FilterChipData('Collares', false),
    FilterChipData('Dijes', false),
    FilterChipData('Pulseras', false),
    FilterChipData('Sombreros', false),
    FilterChipData('Activo', false),
    FilterChipData('Inactivo', false),
  ];
  final double spacingWidth = 8;
  final double spacingHeight = 4;

  @override
  void initState() {
    super.initState();
    _addProductToArray();
    //_saveFilterChips();
  }

  void _addProductToArray() {
    for (int i = 0; i < productsData.products.length; i++) {
      visibleProducts.add(productsData.products[i]);
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
    var grid = Stack(
      children: <Widget>[
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 5,
            mainAxisExtent: 230,
          ),
          itemCount: visibleProducts.length,
          itemBuilder: (BuildContext context, int index) {
            String price = "${visibleProducts[index].salePriceProduct}";
            return GestureDetector(
              onTap: () {
                productSelected = _sendProductPage(index);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoProduct(
                      productSelected,
                    ),
                  ),
                );
                /*navigatorKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (context) => InfoProduct(productSelected),
                  ),
                );*/
              },
              child: Card(
                elevation: 5,
                child: GridTile(
                  child: Stack(
                    children: <Widget>[
                      /*Image.asset(
                        'Assets/_DAV9460-Editar.png',
                        fit: BoxFit.cover,
                      ),*/
                      Image.network(
                        '${visibleProducts[index].imagePathProduct}',
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: PopupMenuButton<Menu>(
                          onSelected: (Menu result) {
                            if (result == Menu.Vender) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Descuento al producto'),
                                    content: const Text(
                                        '¿Desea añadir descuento al producto? Para realizar el descuento se enviará la solicitud al administrador.'),
                                    actions: <Widget>[
                                      CupertinoButton(
                                        child: const Text(
                                          'Cancelar',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,
                                            //fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        onPressed: () {
                                          productsData.products[index]
                                                  .quantityProduct -
                                              1;
                                          Navigator.of(context).pop();
                                          /*navigatorKey.currentState!
                                              .pop(context);*/
                                        },
                                      ),
                                      CupertinoButton(
                                        child: const Text(
                                          'Enviar solicitud',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            //fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        onPressed: () {
                                          TextFormField(
                                            autofocus: false,
                                            autocorrect: true,
                                            keyboardType: TextInputType.number,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              fillColor: Colors.grey[290],
                                              filled: true,
                                              hintText:
                                                  'Ingrese el nuevo precio del producto',
                                              hintStyle: const TextStyle(
                                                fontSize: 14.3,
                                              ),
                                            ),
                                            onChanged: (String newPrice) {
                                              setState(() {
                                                productsData.products[index]
                                                        .salePriceProduct =
                                                    double.parse(newPrice);
                                              });
                                            },
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (newPrice) => newPrice !=
                                                        null &&
                                                    newPrice !=
                                                        productsData
                                                            .products[index]
                                                            .salePriceProduct
                                                            .toString()
                                                ? 'El precio del producto no puede ser igual al precio anterior'
                                                : null,
                                          );
                                          productsData.products[index]
                                                  .quantityProduct -
                                              1;
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (result == Menu.Editar) {
                              /*navigatorKey.currentState!.push(
                                  MaterialPageRoute(
                                    builder: (context) => ForgotPassword(),
                                  ),
                                );
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => AddProduct(productSelected)),
                              );*/
                            } else if (result == Menu.Eliminar) {
                              deleteProduct(index);
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<Menu>>[
                            const PopupMenuItem<Menu>(
                              value: Menu.Vender,
                              child: Text(
                                'Vender',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            const PopupMenuItem<Menu>(
                              value: Menu.Editar,
                              child: Text(
                                'Editar',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            const PopupMenuItem<Menu>(
                              value: Menu.Eliminar,
                              child: Text(
                                'Eliminar',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30, left: 10),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            visibleProducts[index].nameProduct,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 9, left: 10),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            price,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );

    if (visibleProducts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Column(
            children: const <Widget>[
              Icon(
                Icons.warning,
                color: Colors.grey,
                size: 100,
              ),
              Text(
                'No hay productos creados.',
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Column(children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 7),
            child: CupertinoSearchTextField(
              autocorrect: true,
              autofocus: false,
              borderRadius: BorderRadius.circular(10),
              placeholder: 'Buscar producto',
              onChanged: searchProducts,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 50, left: 15, right: 20, bottom: 20),
            child: Wrap(
              runSpacing: -4,
              spacing: 6,
              children: filterChips.map((filterChips) {
                return FilterChip(
                  label: Text(filterChips._label),
                  labelStyle: TextStyle(
                    color:
                        filterChips._isSelected ? optionalColor : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  selected: filterChips._isSelected,
                  onSelected: (_isSelected) {
                    setState(() {
                      filterChips._isSelected = _isSelected;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            child: grid,
          ),
        ]),
      );
    }
  }

  void searchProducts(String search) {
    if (search != "") {
      final suggestion = visibleProducts.where((prdct) {
        final productName = prdct.nameProduct.toLowerCase();
        final input = search.toLowerCase();
        return productName.contains(input);
      }).toList();
      setState(() => visibleProducts = suggestion);
    } else {
      setState(() {
        visibleProducts.clear();
        for (int i = 0; i < productsData.products.length; i++) {
          visibleProducts.add(productsData.products[i]);
        }
      });
    }
  }

  void deleteProduct(int product) {
    setState(() {
      visibleProducts.removeAt(product);
    });

    for (int i = 0; i < productsData.products.length; i++) {
      if (i == product) {
        Localstore.instance
            .collection("products")
            .doc(productsData.products[i].productId)
            .delete();
      }
    }
  }
}

class FilterChipData {
  String _label = "";
  bool _isSelected = false;

  FilterChipData(String label, bool isSelected) {
    _label = label;
    _isSelected = isSelected;
  }

  void set label(String label) {
    _label = label;
  }

  String get label {
    return _label;
  }

  void set isSelected(bool isSelected) {
    _isSelected = isSelected;
  }

  bool get isSelected {
    return _isSelected;
  }
}

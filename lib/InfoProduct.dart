import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:first_proyect/model/Product.dart';

class InfoProduct extends StatefulWidget {
  Product productSelected;
  InfoProduct(this.productSelected, { Key? key }) : super(key: key);

  @override
  State<InfoProduct> createState() => _InfoProductState();
}

class _InfoProductState extends State<InfoProduct> {
  String category = "";
  String status = "";

  @override
  initState(){
    super.initState();
    category = _showCategoryProduct(widget.productSelected.categoryProduct);
    status = _showStatusProduct(widget.productSelected.statusProduct);
  }

  String _showCategoryProduct(int category){
    String catego = "";
    switch (category) {
      case 1: catego = "Anillo";
        break;
      case 2: catego = "Pulsera";
        break;
      case 3: catego = "Aretes";
        break;
      case 4: catego = "Dije";
        break;
      case 5: catego = "Collar";
        break;
      case 6: catego = "Sombrero";
    }
    return catego;
  }

  String _showStatusProduct(int status){
    String stat = "";
    switch (status) {
      case 1: stat = "Activa";
        break;
      case 2: stat = "Inactiva";
        break;
    }
    return stat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 152, 0, 1),
        title: const Text(
          'Descripción del producto',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,top: 20.0,right: 20.0,bottom: 10.0),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'Anillo/_DAV9460-Editar.png',
                  width: 500,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 20.0,bottom: 0.0),
                    child: Text(
                      'Nombre: ${widget.productSelected.nameProduct}',
                      style: const TextStyle(
                        fontSize: 19.5,
                        fontStyle: FontStyle.normal
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 10.0,bottom: 0.0),
                    child: Text(
                      'Material: ${widget.productSelected.materialProduct}',
                      style: const TextStyle(
                        fontSize: 19.5,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 10.0,bottom: 0.0),
                    child: Text(
                      'Descripción: ${widget.productSelected.descriptionProduct}',
                      style: const TextStyle(
                        fontSize: 19.5,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 10.0,bottom: 0.0),
                    child: Text(
                      'Categoría: $category',
                      style: const TextStyle(
                        fontSize: 19.5,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 10.0,bottom: 0.0),
                    child: Text(
                      'Estado: $status',
                      style: const TextStyle(
                        fontSize: 19.5,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 10.0,bottom: 0.0),
                    child: Text(
                      'Precio de venta: ${widget.productSelected.salePriceProduct}',
                      style: const TextStyle(
                        fontSize: 19.5,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 10.0,bottom: 0.0),
                    child: Text(
                      'Costo de producción: ${widget.productSelected.productionPriceProduct}',
                      style: const TextStyle(
                        fontSize: 19.5,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 10.0,bottom: 0.0),
                    child: Text(
                      'Cantidad restante: ${widget.productSelected.quantityProduct}',
                      style: const TextStyle(
                        fontSize: 19.5,
                      ),
                    ),
                  ),
                ),
                /*Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 10.0,bottom: 0.0),
                    child: SizedBox(
                      height: 300,
                      child: widget.productSelected.imagePathProduct == null ? const Center() : Image.file(widget.productSelected.imagePathProduct!),
                    )
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
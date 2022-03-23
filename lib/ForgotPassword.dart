import 'package:first_proyect/HomeScreen.dart';
import 'package:flutter/material.dart';

class Product {
  const Product({required this.name,required this.price});

  final String name;
  final String price;
}

typedef InventoryChanged = Function(Product product);

class InventoryGridListItem extends StatelessWidget {
  InventoryGridListItem({
    required this.product,
    required this.changed,
  }) : super(key: ObjectKey(product));

  final Product product;
  final InventoryChanged changed;

  TextStyle? _getTextStyle(BuildContext context) {
    return const TextStyle(
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        changed(product);
      },
      title: Text(
        product.price,
        style: _getTextStyle(context),
      ),
      leading: Text(
        product.name,
        style: _getTextStyle(context),
      ),
    );
  }
}

class InventoryList extends StatefulWidget {
  const InventoryList({required this.products, Key? key}) : super(key: key);

  final List<Product> products;

  // The framework calls createState the first time
  // a widget appears at a given location in the tree.
  // If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework re-uses
  // the State object instead of creating a new State object.

  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {

  void _handleCartChanged(Product product) {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen())
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: widget.products.map((Product product) {
          return InventoryGridListItem(
            product: product,
            changed: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}

class ForgotPassword extends StatefulWidget{
  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword>{
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: InventoryList(
      products: [
        Product(name: 'Xkull',price: '2000'),
        Product(name: 'Luna Lunera',price: '5014'),
        Product(name: 'Juan II',price: '563213'),
        Product(name: 'Narayana',price: '45646'),
        Product(name: 'Water Dragon',price: '849'),
        Product(name: 'Camaleon',price: '87954'),
        Product(name: 'Flor de Loto',price: '8456'),
        Product(name: 'Zen',price: '13215'),
        Product(name: 'Tullus',price: '2000'),
        Product(name: 'Warrio',price: '5000'),
      ],
    ),
    );
  }
}

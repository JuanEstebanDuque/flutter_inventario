import 'package:first_proyect/model/storeData.dart';
import 'package:flutter/material.dart';

class InfoStore extends StatefulWidget {
  const InfoStore({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _InfoStoreState();
}

class _InfoStoreState extends State<InfoStore> {
  Color primaryColor = const Color.fromRGBO(240, 165, 0, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Información de la tienda',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                  'Nombre de la tienda: ' + "${storeData.store[0].storeName}")),
        ),
      ),
    );
  }
}

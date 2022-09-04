import 'package:flutter/material.dart';

class AddEmployeeCompany extends StatefulWidget {
  const AddEmployeeCompany({ Key? key }) : super(key: key);

  @override
  State<AddEmployeeCompany> createState() => _AddEmployeeCompany();
}

class _AddEmployeeCompany extends State<AddEmployeeCompany> {

  Color primaryColor = const Color.fromRGBO(240, 165, 0,1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Añadir empleado',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 2,
      ),
      body: Center(
        child: Text('Añadir empleados'),
      ),
    );
  }
}
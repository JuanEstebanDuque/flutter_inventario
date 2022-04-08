import 'package:flutter/material.dart';

class AddEmployeeCompany extends StatefulWidget {
  const AddEmployeeCompany({ Key? key }) : super(key: key);

  @override
  State<AddEmployeeCompany> createState() => _AddEmployeeCompanyState();
}

class _AddEmployeeCompanyState extends State<AddEmployeeCompany> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 152, 0, 1),
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
import 'package:flutter/material.dart';

class StatisticsReport extends StatefulWidget {
  const StatisticsReport({ Key? key }) : super(key: key);

  @override
  State<StatisticsReport> createState() => _StatisticsReportState();
}

class _StatisticsReportState extends State<StatisticsReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 152, 0, 1),
        title: const Text(
          'Informe y estadística',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 2,
      ),
      body: Center(
        child: Text('Estadísticas y reporte'),
      ),
    );
  }
}
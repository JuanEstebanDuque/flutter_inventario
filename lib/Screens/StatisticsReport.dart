import 'package:flutter/material.dart';

class StatisticsReport extends StatefulWidget {
  const StatisticsReport({Key? key}) : super(key: key);
  @override
  State<StatisticsReport> createState() => _StatisticsReportState();
}

class _StatisticsReportState extends State<StatisticsReport> {
  Color primaryColor = const Color.fromRGBO(240, 165, 0, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
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

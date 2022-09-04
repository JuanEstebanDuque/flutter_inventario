import 'package:first_proyect/Screens/Register.dart';
import 'package:first_proyect/Screens/StartingApp.dart';
import 'package:first_proyect/model/UserApp.dart';
import 'package:flutter/material.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:localstore/localstore.dart';
import 'Screens/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  Future<void> readLS() async {
    final items = await Localstore.instance.collection("users").get();
    if (items!.entries.isNotEmpty) {
      for (var entry in items.entries) {
        var user = UserApp.fromJson(entry.value);
        saveUser.add(user);
      }
    }
  }

  final List<UserApp> saveUser = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          } else if (snapshot.hasData) {
            const MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Inventaty',
              home: Login(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Inventaty',
            home: StartingApp(),
          );
        });
  }
}

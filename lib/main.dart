import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_proyect/Screens/AuthScreen.dart';
import 'package:first_proyect/Screens/HomeScreen.dart';
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
  await Firebase.initializeApp();
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);

  initializeDateFormatting().then((_) => runApp(MyApp()));
}

//final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.white, color: Colors.black));
          } else if (snapshot.hasData) {
            const MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Inventaty',
              home: Login(),
            );
          }
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Inventaty',
            home: StartingApp(),
          );
        });
  }

  /*@override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "AnarchyStores",
        home: MainPage(),
      );*/
}

/*class MainPage extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                      'No se pudo conectar a la red. Error ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return AuthScreen();
            }
          },
        ),
        return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Inventaty',
            home: Login(),
          );
        } else {
          const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Inventaty',
            home: StartingApp(),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
    return FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.white, color: Colors.black));
          } else if (snapshot.hasData) {
            const MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Inventaty',
              home: Login(),
            );
          }
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Inventaty',
            home: StartingApp(),
          );
        })
      );
}*/

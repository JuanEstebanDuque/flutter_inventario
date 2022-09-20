import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_proyect/Screens/Login.dart';
import 'package:first_proyect/Screens/Register.dart';
import 'package:first_proyect/Screens/createStore.dart';
import 'package:first_proyect/model/storeData.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:nice_intro/intro_screen.dart';
import 'package:nice_intro/intro_screens.dart';

import '../model/UserApp.dart';
import 'package:first_proyect/Colors App/Constants.dart';

class StartingApp extends StatefulWidget {
  const StartingApp({Key? key}) : super(key: key);
  @override
  State<StartingApp> createState() => _StartingAppState();
}

class _StartingAppState extends State<StartingApp> {
  final List<UserApp> saveUser = [];

  @override
  void initState() {
    super.initState();
    //readLS();
    readFirebase();
  }

  /*Future<void> readLS() async {
    final items = await Localstore.instance.collection("users").get();
    if (items!.entries.isNotEmpty) {
      for (var entry in items.entries) {
        var user = UserApp.fromJson(entry.value);
        saveUser.add(user);
      }
    }
    if (saveUser.isNotEmpty) {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      });
    }
  }*/

  Future<void> readFirebase() async {
    if (FirebaseAuth.instance.authStateChanges() != null) {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
      });
    } else {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Register()),
            (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screens = IntroScreens(
      onDone: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => Register(),
            ),
            (Route<dynamic> route) => false);
      },
      onSkip: () => ('Skipping the intro slides'),
      footerBgColor: primaryColor.withOpacity(.9),
      activeDotColor: Colors.white,
      footerRadius: 20.0,
      indicatorType: IndicatorType.CIRCLE,
      skipText: 'Saltar',
      textColor: Colors.black,
      slides: [
        IntroScreen(
          title: '',
          description: 'BIENVENIDO A ANARCHY INVENTORY',
          textStyle: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          headerBgColor: Colors.white,
          header: Center(
            child: SizedBox(
              height: 330.0,
              width: 330.0,
              child: Image.asset('Assets/AnarchyStoresLogo1.png'),
            ),
          ),
        ),
        IntroScreen(
          title: 'Tiendas',
          headerBgColor: Colors.white,
          description:
              "Permite agregar diferentes tiendas para que puedas ver los productos que hay en cada ellas",
          textStyle: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          header: Center(
            child: SizedBox(
              height: 390.0,
              width: 390.0,
              child: Image.asset('Assets/storesProducts.png'),
            ),
          ),
        ),
        IntroScreen(
          title: 'Creación',
          description:
              'Permite crear productos y agregarlos a la lista de tu inventario',
          headerBgColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          header: Center(
            child: SizedBox(
              height: 370.0,
              width: 370.0,
              child: Image.asset('Assets/createProducts.png'),
            ),
          ),
        ),
        IntroScreen(
          title: 'Descuentos',
          headerBgColor: Colors.white,
          description: "Permite aplicar descuentos a productos seleccionados",
          textStyle: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          header: Center(
            child: SizedBox(
              height: 370.0,
              width: 370.0,
              child: Image.asset('Assets/discountsProducts.png'),
            ),
          ),
        ),
        IntroScreen(
          title: 'Añadir empleados',
          headerBgColor: Colors.white,
          description:
              "Permite añadir empleados a la tienda que quieras para que puedan ser administrardos",
          textStyle: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          header: Center(
            child: SizedBox(
              height: 370.0,
              width: 370.0,
              child: Image.asset('Assets/addEmployeesProducts.png'),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      body: screens,
    );
  }
}

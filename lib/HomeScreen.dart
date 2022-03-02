import 'package:flutter/material.dart';
import 'Setting.dart';
import 'Profile.dart';
import 'Inventario.dart';

class HomeScreen extends StatefulWidget{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  late int currentPage;

  _getDrawerItemWidget(int pos){
    switch(pos){
      case 0: return Settings();
      case 1: return Profile();
    }
  }



  _screenSelected(int pos){
    switch(pos){
      case 0: return HomeScreen();
      case 1: return Inventario();
    }
  }

  _showNamePage(int pos){
    if(pos == 0){
      return "Inicio";
    } else if (pos == 1){
      return "Inventario";
    }
  }

  _changeScreen(int index){
    setState(() {
      currentPage = index;
      _screenSelected(currentPage);
      _showNamePage(currentPage);
    });
  }


  @override
  Widget build(BuildContext context) {
    currentPage = 0;

    return Scaffold(
      //*AppBar
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          _showNamePage(currentPage),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text(
                  'juan',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              accountEmail: Text(
                  'juan@gmail.com',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Text(
                  'J',
                  style: TextStyle(
                    fontSize:40.0,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Settings'),
              leading: const Icon(Icons.settings,
                color: Colors.black,
              ),
              onTap: (){
                //_onSelectItem(0);
              },
            ),
            ListTile(
              title: const Text('Profile'),
              leading: const Icon(Icons.account_circle,
                color: Colors.black,
              ),
              onTap: (){
                //_onSelectItem(1);
              },
            ),
          ],
        ),
      ),
      body: _screenSelected(currentPage),

      //*Boton de navegación
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35.0,
        backgroundColor: Colors.orange,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.inventory),
              label: 'Inventario',
            backgroundColor: Colors.amber,
          ),
        ],
        currentIndex: currentPage,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.5),
        onTap: (index) {

        },
      ),
    );
  }
}

/*
class CustomScreen extends StatelessWidget {

  final Color color;

  const CustomScreen({ required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('CustomScrenn'),
      ),
    );
  }
}
*/

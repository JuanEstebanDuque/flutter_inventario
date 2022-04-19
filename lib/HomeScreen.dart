import 'package:first_proyect/AddProduct.dart';
import 'package:first_proyect/Login.dart';
import 'package:first_proyect/model/Product.dart';
import 'package:first_proyect/model/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'Inventary.dart';
import 'Home.dart';
import 'Setting.dart';
import 'Profile.dart';
import 'Login.dart';
import 'StatisticsReport.dart';
import 'AddEmployeeCompany.dart';
//import 'AddProduct.dart';

//TODO: añadir arreglo de los productos aquí para que los lea

class HomeScreen extends StatefulWidget{

  List<User> user = [];
  HomeScreen(this.user, {Key? key}):super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> visibleProducts = [];

  @override
  void initState(){
    super.initState();
    _userNameAdmin = _showInfoAdmin(0);
    _userEmialAdmin = _showInfoAdmin(1);
    readLS();
  }

  Future<void> readLS() async {
    final items = await Localstore.instance.collection('products').get();
    for (var entry in items!.entries) {
      var product = Product.fromJson(entry.value);
      visibleProducts.add(product);
      print(product.nameProduct);
    }
  }

  String _userNameAdmin = "";
  String _userEmialAdmin = "";

  int currentPage = 0;

  _screenSelected(int pos){
    switch(pos){
      case 0: return Home(visibleProducts);
      case 1: return Inventary(visibleProducts);
    }
  }

  _showNamePage(int pos){
    if(pos == 0){
      return "Inicio";
    } else if (pos == 1){
      return "Inventario";
    }
  }

  String _showInfoAdmin(int prefer){
    String name = "";
    String email = "";
    for(int i=0;i<widget.user.length;i++){
      if(widget.user[i].userRole == 1){
        if(prefer == 0){
          name = widget.user[i].userName;
          return name;
        } else if (prefer == 1){
          email = widget.user[i].userEmail;
          return email;
        }
      }
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const  Color.fromRGBO(255, 152, 0, 1),
        title: Text(
          _showNamePage(currentPage),
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 2,
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                  _userNameAdmin,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              accountEmail: Text(
                  _userEmialAdmin,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.orange,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: const Color.fromRGBO(133, 109, 119, 1),
                child: Text(
                  _userNameAdmin.characters.first,
                  style: const TextStyle(
                    fontSize:40.0,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Ajustes'),
              leading: const Icon(Icons.settings,
                color: Colors.black,
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Setting()),
                );
              },
            ),
            ListTile(
              title: const Text('Perfil'),
              leading: const Icon(Icons.account_circle,
                color: Colors.black,
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
            ),
            ListTile(
              title: const Text('Informe y estadística'),
              leading: const Icon(Icons.bar_chart_rounded,
                color: Colors.black,
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StatisticsReport()),
                );
              },
            ),
            ListTile(
              title: const Text('Añadir empleado'),
              leading: const Icon(Icons.person_add_alt_sharp,
                color: Colors.black,
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddEmployeeCompany()),
                );
              },
            ),
          ],
        ),
      ),
      body: _screenSelected(currentPage),
      

      //*Boton de navegación
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        iconSize: 35.0,
        backgroundColor: const Color.fromRGBO(255, 152, 0, 1),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.inventory_outlined),
              label: 'Inventario',
            backgroundColor: Colors.black,
          ),
        ],
        currentIndex: currentPage,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(0.5),
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(255, 152, 0, 1),
        autofocus: true,
        highlightElevation: 20,
        child: const Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => AddProduct(visibleProducts,widget.user)),
          );
        },
        elevation: 10,
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'model/User.dart';

class Profile extends StatefulWidget{
  List<User> user = [];
  String userEmailSelected;
  Profile(this.user,this.userEmailSelected,{Key? key}):super(key: key);
  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile>{

  int profileSelected = -1;
  Color primaryColor = const Color.fromRGBO(255, 152, 0, 1);
  String _sexProfile = "";
  String _roleProfile = "";

  @override
  void initState() {
    super.initState();
    profileSelected = profileParameters();
    sexProfile();
    roleProfile();
  }

  int profileParameters(){
    int profile = -1;
    for (int i=0; i<widget.user.length; i++){
      if(widget.user[i].userEmail == widget.userEmailSelected){
        profile = i;
      }
    }
    return profile;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Perfil',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0,left: 16,right: 10,bottom: 10.0),
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Mi usuario',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    'Actualiza tus datos personales.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    'Nombre: ' + widget.user[profileSelected].userName,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    'Apellidos: ' + widget.user[profileSelected].userLastName,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    'Identificación: ' + widget.user[profileSelected].userId,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Correo electrónico: ' + widget.user[profileSelected].userEmail,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Teléfono: ' + widget.user[profileSelected].userPhone,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    'Sexo: ' + _sexProfile,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Rol: ' + _roleProfile,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Empresa: ' + widget.user[profileSelected].userCompany,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sexProfile(){
    if(widget.user[profileSelected].userSex == 1){
      _sexProfile = "Hombre";
    }else if(widget.user[profileSelected].userSex == 2){
      _sexProfile = "Mujer";
    }
  }

  void roleProfile(){
    if(widget.user[profileSelected].userRole == 1){
      _roleProfile = "Administrador";
    }else if(widget.user[profileSelected].userRole == 2){
      _roleProfile = "Colaborador";
    }else if(widget.user[profileSelected].userRole == 3){
      _roleProfile = "Empleado";
    }
  }

}
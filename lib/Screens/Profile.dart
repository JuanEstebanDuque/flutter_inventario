import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:first_proyect/model/User.dart';

class Profile extends StatefulWidget{
  List<User> user = [];
  String userEmailSelected;
  Profile(this.user,this.userEmailSelected,{Key? key}):super(key: key);
  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile>{

  var idFormatter = MaskTextInputFormatter(mask: '##########', filter: { "#": RegExp(r'[0-9]') });
  var phoneFormatter = MaskTextInputFormatter(mask: '##########', filter: { "#": RegExp(r'[0-9]') });

  int profileSelected = -1;
  Color primaryColor = const Color.fromRGBO(255, 152, 0, 1);



  String _userName = "";
  String _userLastName = "";
  String _userId = "";
  String _userPhone = "";
  String _userCompany = "";
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
          padding: const EdgeInsets.only(top: 15.0,left: 16,right: 13,bottom: 10.0),
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Mi usuario.',
                  style: TextStyle(
                    fontSize: 23,
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
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Nombre',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  autofocus: false,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: widget.user[profileSelected].userName,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                  onChanged: (String nameRegister) {
                    setState(() {
                      _userName = nameRegister;
                    });
                  },
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Apellidos',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  autofocus: false,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: widget.user[profileSelected].userLastName,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                  onChanged: (String lastNameRegister) {
                    setState(() {
                      _userLastName = lastNameRegister;
                    });
                  },
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Número de identificación',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  inputFormatters: [idFormatter],
                  autofocus: false,
                  autocorrect: true,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: widget.user[profileSelected].userId,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                  onChanged: (String idRegister) {
                    setState(() {
                      _userId = idRegister;
                    });
                  },
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    'Correo electrónico',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: widget.user[profileSelected].userEmail,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[900],
                    ),
                  ),
                  onChanged: (String emailRegister) {
                  },
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Teléfono',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  inputFormatters: [phoneFormatter],
                  autofocus: false,
                  autocorrect: true,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: widget.user[profileSelected].userPhone,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                  onChanged: (String phoneRegister) {
                    setState(() {
                      _userPhone = phoneRegister;
                    });
                  },
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Sexo',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: _sexProfile,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[900],
                    ),
                  ),
                  onChanged: (String sexRegister) {
                  },
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Rol',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: _roleProfile,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[900],
                    ),
                  ),
                  onChanged: (String rolRegister) {
                  },
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Empresa',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 10.0, right: 0.0, bottom: 0.0),
                child: TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.grey[290],
                    filled: true,
                    hintText: widget.user[profileSelected].userCompany,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[900],
                    ),
                  ),
                  onChanged: (String companyRegister) {
                  },
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
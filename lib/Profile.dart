import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  const Profile({Key? key}):super(key: key);
  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 152, 0, 1),
        title: const Text(
          'Perfil',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 2,
      ),
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}
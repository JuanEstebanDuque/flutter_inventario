import 'package:first_proyect/model/UserRole.dart';

class User{
  //attributes
  String _userId = "";
  String _userName = "";
  String _userLastName = "";
  String _userEmail = "";
  String _userPassword = "";
  String _userPhone = "";
  int _userRole = 0;

  //relations

  //methods
  User(String userId,String userName,String userLastName,String userEmail,String userPassword,String userPhone,int userRole){
    _userId = userId;
    _userName = userName;
    _userLastName = userLastName;
    _userEmail = userEmail;
    _userPassword = userPassword;
    _userPhone = userPhone;
    _userRole = userRole;
  }

  void set userId(String userId){
    _userId = userId;
  }

  String get userId{
    return _userId;
  }

  void set userName(String userName){
    _userName = userName;
  }

  String get userName{
    return _userName;
  }

  void set userLastName(String userLastName){
    _userLastName = userLastName;
  }

  String get userLastName{
    return _userLastName;
  }

  void set userEmail(String userEmail){
    _userEmail = userEmail;
  }

  String get userEmail{
    return _userEmail;
  }

  void set userPassword(String userPassword){
    _userPassword = userPassword;
  }

  String get userPassword{
    return _userPassword;
  }

  void set userPhone(String userPhone){
    _userPhone = userPhone;
  }

  String get userPhone{
    return _userPhone;
  }

  void set userRole(int userRole){
    _userRole = userRole;
  }

  int get userRole{
    return _userRole;
  }

  Map<String, dynamic> toJson(){
    return {
      "userId": _userId,
      "userName": _userName,
      "userLastName": _userLastName,
      "userEmail": _userEmail,
      "userPassword": _userPassword,
      "userPhone": _userPhone,
      "userRole": _userRole,
    };
  }

  static User fromJson(Map<String, dynamic> map){
    return User(
      map['userId'],
      map['userName'], 
      map['userLastName'], 
      map['userEmail'], 
      map['userPassword'], 
      map['userPhone'],
      map['userRole']);
  }

}
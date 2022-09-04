import 'package:first_proyect/model/UserRole.dart';

class UserApp{
  //attributes
  String _userCode = "";
  String _userName = "";
  String _userLastName = "";
  String _userId = "";
  String _userEmail = "";
  String _userPassword = "";
  String _userPhone = "";
  int _userSex = 0;
  int _userRole = 0;
  String _userCompany = "";

  //relations

  //methods
  UserApp(String userCode,String userName,String userLastName,String userId,String userEmail,String userPassword,String userPhone,int userSex,int userRole,String userCompany){
    _userCode = userCode;
    _userName = userName;
    _userLastName = userLastName;
    _userId = userId;
    _userEmail = userEmail;
    _userPassword = userPassword;
    _userPhone = userPhone;
    _userSex = userSex;
    _userRole = userRole;
    _userCompany = userCompany;
  }

  void set userCode(String userCode){
    _userCode = userCode;
  }

  String get userCode{
    return _userCode;
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

  void set userId(String userId){
    _userId = userId;
  }

  String get userId{
    return _userId;
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

  void set userSex(int userSex){
    _userSex = userSex;
  }

  int get userSex{
    return _userSex;
  }

  void set userRole(int userRole){
    _userRole = userRole;
  }

  int get userRole{
    return _userRole;
  }

  void set userCompany(String userCompany){
    _userCompany = userCompany;
  }

  String get userCompany{
    return _userCompany;
  }

  Map<String, dynamic> toJson(){
    return {
      "userCode": _userCode,
      "userName": _userName,
      "userLastName": _userLastName,
      "userId": _userId,
      "userEmail": _userEmail,
      "userPassword": _userPassword,
      "userPhone": _userPhone,
      "userSex": _userSex,
      "userRole": _userRole,
      "userCompany": _userCompany
    };
  }

  static UserApp fromJson(Map<String, dynamic> map){
    return UserApp(
      map['userCode'],
      map['userName'], 
      map['userLastName'], 
      map['userId'],
      map['userEmail'], 
      map['userPassword'], 
      map['userPhone'],
      map['userSex'],
      map['userRole'],
      map['userCompany']
    );
  }

}
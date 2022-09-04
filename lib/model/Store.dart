import 'package:cloud_firestore/cloud_firestore.dart';

import 'Product.dart';

class Store {
  //attributes
  String _storeId = "";
  String _storeName = "";
  String _storeAddress = "";
  String _storePhone = "";
  List<dynamic> _products = [];

  //relations

  //methods
  Store(String storeId, String storeName, String storeAddress,
      String storePhone, List<dynamic> products) {
    _storeId = storeId;
    _storeName = storeName;
    _storeAddress = storeAddress;
    _storePhone = storePhone;
    _products = products;
  }

  void set storeId(String storeId) {
    _storeId = storeId;
  }

  String get storeId {
    return _storeId;
  }

  void set storeName(String storeName) {
    _storeName = storeName;
  }

  String get storeName {
    return _storeName;
  }

  void set storeAddress(String storeAddress) {
    _storeAddress = storeAddress;
  }

  String get storeAddress {
    return _storeAddress;
  }

  void set storePhone(String storePhone) {
    _storePhone = storePhone;
  }

  String get storePhone {
    return _storePhone;
  }

  void set products(List<dynamic> products) {
    _products = products;
  }

  List<dynamic> get products {
    return _products;
  }

  /*factory Store.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
    ) {
      final data = snapshot.data();
      return Store(
        _storeId : data?['storeId'],
        data['storeName'],
        data['storeAddress'],
        data['storePhone'],
        data['products'],
      );
  }*/

  Store.fromJson2(Map<String, dynamic> json) {
    _storeId:
    json['storeId']! as String;
    _storeName:
    json['storeName']! as String;
    _storeAddress:
    json['storeAddress']! as String;
    _storePhone = json['storePhone']! as String;
    _products = (json['products']! as List).cast<dynamic>();
  }

  Map<String, Object?> toJson() {
    return {
      "storeId": _storeId,
      "storeName": _storeName,
      "storeAddress": _storeAddress,
      "storePhone": _storePhone,
      "products": _products
    };
  }

  static Store fromJson(Map<String, dynamic> map) {
    return Store(map['storeId'], map['storeName'], map['storeAddress'],
        map['storePhone'], map['products']);
  }
}

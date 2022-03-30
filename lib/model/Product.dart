import 'ProductCategory.dart';
import 'Status.dart';
import 'package:first_proyect/model/ProductCategory.dart';

class Product{
  //attributes
  String _name = '';
  String _material = '';
  String _description = '';
  int _category = ProductCategory.newest;
  int _status = Status.deactive;
  String image = "";
  double _salePrice = 0;
  double _productionPrice = 0;
  int _quantityProduct = 0;

  //relations

  //methods
  Product(String name,String material,String description,int category,int status,double salePrice,double productionPrice,int quantityProduct){
    _name = name;
    _material = material;
    _description = description;
    _category = category;
    _status = status;
    _salePrice = salePrice;
    _productionPrice = productionPrice;
    _quantityProduct = quantityProduct;
  }

  void set name(String name){
    _name = name;
  }

  String get name{
    return _name;
  }

  void set material(String material){
    _material = material;
  }
  
  String get material{
    return _material;
  }

  void set description(String description){
    _description = description;
  }

  String get description{
    return _description;
  }

  void set category(int category){
    _category = category;
  }

  int get category{
    return _category;
  }

  void set status(int status){
    _status = status;
  }

  int get status{
    return _status;
  }

  void set salePrice(double salePrice){
    _salePrice = salePrice;
  }

  double get salePrice{
    return _salePrice;
  }

  void set productionPrice(double productionPrice){
    _productionPrice = productionPrice;
  }

  double get productionPrice{
    return _productionPrice;
  }

  void set quantityProduct(int quantityProduct){
    _quantityProduct = quantityProduct;
  }

  int get quantityProduct{
    return _quantityProduct;
  }

  Map<String, dynamic> toJson(){
    return {
      "name": _name,
      "material": _material,
      "description": _description,
      "image": image,
      "salePrice": _salePrice,
      "productionPrice": _productionPrice,
      "quantityProduct": _quantityProduct,
      "status": _status,
      "category": _category,
    };
  }

  static Product fromJson(Map<String, dynamic> map){
    return Product(
      map['name'], 
      map['material'], 
      map['description'], 
      map['category'], 
      map['status'], 
      map['salePrice'], 
      map['productionPrice'], 
      map['quantityProduct']);
  }

}
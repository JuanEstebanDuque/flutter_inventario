import 'ProductCategory.dart';
import 'Status.dart';
import 'package:first_proyect/model/ProductCategory.dart';

class Product{
  //attributes
  String _name = '';
  String _material = '';
  String _description = '';
  ProductCategory _category = ProductCategory.newest;
  Status _status = Status.deactive;
  String image = "";
  double _salePrice = 0;
  double _productionPrice = 0;
  int _quantityProduct = 0;

  //relations

  //methods
  Product(String name,String material,String description,ProductCategory category,Status status,double salePrice,double productionPrice,int quantityProduct){
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

  void set category(ProductCategory category){
    _category = category;
  }

  ProductCategory get category{
    return _category;
  }

  void set status(Status status){
    _status = status;
  }

  Status get status{
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

}
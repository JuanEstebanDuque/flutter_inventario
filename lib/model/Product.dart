import 'package:flutter/cupertino.dart';
import 'ProductCategory.dart';
import 'Status.dart';

class Product{
  //attributes
  String _productId = "";
  String _nameProduct = '';
  String _materialProduct = '';
  String _descriptionProduct = '';
  int _categoryProduct = 0;
  int _statusProduct = 0;
  String _imagePathProduct = "";
  double _salePriceProduct = 0;
  double _productionPriceProduct = 0;
  int _quantityProduct = 0;

  //relations

  //methods
  Product(String productId,String name,String material,String description,int category,int status,String imagePath,double salePrice,double productionPrice,int quantityProduct){
    _productId = productId;
    _nameProduct = name;
    _materialProduct = material;
    _descriptionProduct = description;
    _categoryProduct = category;
    _statusProduct = status;
    _imagePathProduct = imagePath;
    _salePriceProduct = salePrice;
    _productionPriceProduct = productionPrice;
    _quantityProduct = quantityProduct;
  }

  void set productId(String productId){
    _productId = productId;
  }

  String get productId{
    return _productId;
  }

  void set nameProduct(String nameProduct){
    _nameProduct = nameProduct;
  }

  String get nameProduct{
    return _nameProduct;
  }

  void set materialProduct(String materialProduct){
    _materialProduct = materialProduct;
  }
  
  String get materialProduct{
    return _materialProduct;
  }

  void set descriptionProduct(String descriptionProduct){
    _descriptionProduct = descriptionProduct;
  }

  String get descriptionProduct{
    return _descriptionProduct;
  }

  void set categoryProduct(int categoryProduct){
    _categoryProduct = categoryProduct;
  }

  int get categoryProduct{
    return _categoryProduct;
  }

  void set statusProduct(int statusProduct){
    _statusProduct = statusProduct;
  }

  int get statusProduct{
    return _statusProduct;
  }

  void set imagePathProduct(String imagePathProduct){
    _imagePathProduct = imagePathProduct;
  }

  String get imagePathProduct{
    return _imagePathProduct;
  }

  void set salePriceProduct(double salePriceProduct){
    _salePriceProduct = salePriceProduct;
  }

  double get salePriceProduct{
    return _salePriceProduct;
  }

  void set productionPriceProduct(double productionPriceProduct){
    _productionPriceProduct = productionPriceProduct;
  }

  double get productionPriceProduct{
    return _productionPriceProduct;
  }

  void set quantityProduct(int quantityProduct){
    _quantityProduct = quantityProduct;
  }

  int get quantityProduct{
    return _quantityProduct;
  }

  Map<String, dynamic> toJson(){
    return {
      "productId": _productId,
      "nameProduct": _nameProduct,
      "materialProduct": _materialProduct,
      "descriptionProduct": _descriptionProduct,
      "categoryProduct": _categoryProduct,
      "statusProduct": _statusProduct,
      "imagePathProduct": _imagePathProduct,
      "salePriceProduct": _salePriceProduct,
      "productionPriceProduct": _productionPriceProduct,
      "quantityProduct": _quantityProduct,
    };
  }

  static Product fromJson(Map<String, dynamic> map){
    return Product(
      map['productId'],
      map['nameProduct'], 
      map['materialProduct'], 
      map['descriptionProduct'], 
      map['categoryProduct'], 
      map['statusProduct'],
      map['imagePathProduct'], 
      map['salePriceProduct'], 
      map['productionPriceProduct'], 
      map['quantityProduct']);
  }

}
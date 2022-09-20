import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'ProductCategory.dart';
import 'Status.dart';
import 'dart:io';

class Product {
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
  int _minimunStock = 0;
  bool _isDiscounted = false;
  bool _isChecked = false;

  //relations

  //methods
  Product(
      String productId,
      String name,
      String material,
      String description,
      int category,
      int status,
      String imagePath,
      double salePrice,
      double productionPrice,
      int quantityProduct,
      int minimunStock,
      bool isDiscounted) {
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
    _minimunStock = minimunStock;
    _isDiscounted = isDiscounted;
  }

  void set productId(String productId) {
    _productId = productId;
  }

  String get productId {
    return _productId;
  }

  void set nameProduct(String nameProduct) {
    _nameProduct = nameProduct;
  }

  String get nameProduct {
    return _nameProduct;
  }

  void set materialProduct(String materialProduct) {
    _materialProduct = materialProduct;
  }

  String get materialProduct {
    return _materialProduct;
  }

  void set descriptionProduct(String descriptionProduct) {
    _descriptionProduct = descriptionProduct;
  }

  String get descriptionProduct {
    return _descriptionProduct;
  }

  void set categoryProduct(int categoryProduct) {
    _categoryProduct = categoryProduct;
  }

  int get categoryProduct {
    return _categoryProduct;
  }

  void set statusProduct(int statusProduct) {
    _statusProduct = statusProduct;
  }

  int get statusProduct {
    return _statusProduct;
  }

  void set imagePathProduct(String imagePathProduct) {
    _imagePathProduct = imagePathProduct;
  }

  String get imagePathProduct {
    return _imagePathProduct;
  }

  void set salePriceProduct(double salePriceProduct) {
    _salePriceProduct = salePriceProduct;
  }

  double get salePriceProduct {
    return _salePriceProduct;
  }

  void set productionPriceProduct(double productionPriceProduct) {
    _productionPriceProduct = productionPriceProduct;
  }

  double get productionPriceProduct {
    return _productionPriceProduct;
  }

  void set quantityProduct(int quantityProduct) {
    _quantityProduct = quantityProduct;
  }

  int get quantityProduct {
    return _quantityProduct;
  }

  int get minimunStock {
    return _minimunStock;
  }

  void set minimunStock(int minimunStock) {
    _minimunStock = minimunStock;
  }

  void set isDiscounted(bool isDiscounted) {
    _isDiscounted = isDiscounted;
  }

  bool get isDiscounted {
    return _isDiscounted;
  }

  void set isChecked(bool isChecked) {
    _isChecked = isChecked;
  }

  bool get isChecked {
    return _isChecked;
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (productId != null) 'productId': productId,
      if (nameProduct != null) 'nameProduct': nameProduct,
      if (materialProduct != null) 'materialProduct': materialProduct,
      if (descriptionProduct != null) 'descriptionProduct': descriptionProduct,
      if (categoryProduct != null) 'categoryProduct': categoryProduct,
      if (statusProduct != null) 'statusProduct': statusProduct,
      if (imagePathProduct != null) 'imagePathProduct': imagePathProduct,
      if (salePriceProduct != null) 'salePriceProduct': salePriceProduct,
      if (productionPriceProduct != null)
        'productionPriceProduct': productionPriceProduct,
      if (quantityProduct != null) 'quantityProduct': quantityProduct,
      if (minimunStock != null) 'minimunStock': minimunStock,
      if (isDiscounted != null) 'isDiscounted': isDiscounted,
    };
  }

  Product.fromJson2(Map<String, dynamic> json) {
    _productId = json['productId'] as String;
    _nameProduct = json['nameProduct'] as String;
    _materialProduct = json['materialProduct'] as String;
    _descriptionProduct = json['descriptionProduct'] as String;
    _categoryProduct = json['categoryProduct'] as int;
    _statusProduct = json['statusProduct'] as int;
    _imagePathProduct = json['imagePathProduct'] as String;
    _salePriceProduct = json['salePriceProduct'] as double;
    _productionPriceProduct = json['productionPriceProduct'] as double;
    _quantityProduct = json['quantityProduct'] as int;
    _minimunStock = json['minimunStock'] as int;
    _isDiscounted = json['isDiscounted'] as bool;
  }

  Map<String, dynamic> toJson() {
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
      "minimunStock": _minimunStock,
      "isDiscounted": _isDiscounted
    };
  }

  static Product fromJson(Map<String, dynamic> map) {
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
        map['quantityProduct'],
        map['minimunStock'],
        map['isDiscounted']);
  }
}

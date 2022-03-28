import 'package:first_proyect/model/ProductData.dart';
import 'Category.dart';
import 'Status.dart';
import 'package:first_proyect/model/Category.dart';

class Product{
  //attributes
  String _name = '';
  String _material = '';
  String _description = '';
  Category _category = Category.newest;
  Status _status = Status.deactive;
  String image = "";
  double _salePrice = 0;
  double _productionPrice = 0;
  int _quantityProduct = 0;

  //relations

  //methods
  Product(String name,String material,String description,Category category,Status status,double salePrice,double productionPrice,int quantityProduct){
    _name = name;
    _material = material;
    _description = description;
    _category = category;
    _status = status;
    _salePrice = salePrice;
    _productionPrice = productionPrice;
    _quantityProduct = quantityProduct;
  }

  void addProduct(String name,String material,String description,Category category,Status status,double salePrice,double productionPrice,int quantityProduct){
    ProductData().product.add(Product(name, material, description, category, status, salePrice, productionPrice, quantityProduct));
    ProductData().product.add(Product('King Dead', 'Plata 925', 'Precioso Anillo', Category.ring, Status.deactive, 4000, 1800, 10));
    ProductData().product.add(Product('Silver Skull', 'Plata 925', 'Imponente Anillo', Category.ring, Status.active, 1500, 650, 9));
    //ProductData().product.add(Product('Tentáculo', 'Plata 925', 'Imponente Anillo', Category.ring, Status.deactive, 2000, 950, 9));
    //ProductData().product.add(Product('Camaleón', 'Plata 925 y Lapizlazuli', 'Hermoso Anillo', Category.ring, Status.active, 3250, 1500, 10));
    //ProductData().product.add(Product('Juan II', 'Plata 925', 'Lindo', Category.ring, Status.active, 1500, 650, 11));
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

  void set category(Category category){
    _category = category;
  }

  Category get category{
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
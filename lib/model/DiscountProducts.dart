import 'package:first_proyect/model/Product.dart';

class DiscountProduct{
  //attributes

  String _randomKey = "";
  DateTime _discountStartDate = DateTime.now();
  DateTime _discountEndDate = DateTime.now();
  String _discountName = "";
  List<Product> _discountedProducts = [];

  //relations

  //methods
  DiscountProduct(String randomKey,DateTime discountStartDate,DateTime discountEndDate,String discountName,List<Product> discountedProducts){
    _randomKey = randomKey;
    _discountStartDate = discountStartDate;
    _discountEndDate = discountEndDate;
    _discountName = discountName;
    _discountedProducts = discountedProducts;
  }

  void setRandomKey(String randomKey){
    _randomKey = randomKey;
  }

  String get randomKey{
    return _randomKey;
  }

  void set discountStartDate(DateTime discountStartDate){
    _discountStartDate = discountStartDate;
  }

  DateTime get discountStartDate{
    return _discountStartDate;
  }

  void set discountEndDate(DateTime discountEndDate){
    _discountEndDate = discountEndDate;
  }

  DateTime get discountEndDate{
    return _discountEndDate;
  }

  void set discountName(String discountName){
    _discountName = discountName;
  }

  String get discountName{
    return _discountName;
  }

  void set discountedProducts(List<Product> discountedProducts){
    _discountedProducts = discountedProducts;
  }

  List<Product> get discountedProducts{
    return _discountedProducts;
  }

  void addDiscountedProduct(Product discountedProduct){
    _discountedProducts.add(discountedProduct);
  }

  void removeDiscountedProduct(Product discountedProduct){
    _discountedProducts.remove(discountedProduct);
  }

  void clearDiscountedProducts(){
    _discountedProducts.clear();
  }

  bool isDiscountedProduct(Product discountedProduct){
    return _discountedProducts.contains(discountedProduct);
  }

  Map<String, dynamic> toJson(){
    return {
      "randomKey": _randomKey,
      'discountStartDate': _discountStartDate.toString(),
      'discountEndDate': _discountEndDate.toString(),
      'discountName': _discountName,
      'discountedProducts': _discountedProducts.map((e) => e.toJson()).toList()
    };
  }

  static DiscountProduct fromJson(Map<String, dynamic> map){
    return DiscountProduct(
      map['randomKey'],
      DateTime.parse(map['discountStartDate']),
      DateTime.parse(map['discountEndDate']),
      map['discountName'],
      map['discountedProducts'].map((e) => Product.fromJson(e)).toList()
    );
  }

}
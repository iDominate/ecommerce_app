

import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class CartItem extends ChangeNotifier{

 List<Product> list = [] ;

 addProduct(Product product){
   list.add(product);
   print(list[0].name);
   notifyListeners();
 }

 deleteProduct(Product product){
   list.remove(product);
   notifyListeners();
 }
}
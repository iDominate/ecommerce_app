import 'package:ecommerce_app/constants.dart' as k;

class Product {
  String name, price, location, category, description, id;
   int quantity;

  Product(
      {required this.name,
       this.quantity = 1,

      this.price = '',
       this.location = '',
      required this.category,
       this.description = '',
       this.id = ''});




  ///Converts a Product object into a map
 Map<String, dynamic> toMap() {
   return {
     k.kProductName: this.name,
     k.kProductPrice: this.price,
     k.kProductDescription: this.description,
     k.kProductCategory: this.category,
     k.kProductLocation: this.location,


   };
 }

 setQuantity(int qty){
   quantity = qty;
 }

 @override
  String toString() {
    // TODO: implement toString
    return 'Hello World';
  }


}

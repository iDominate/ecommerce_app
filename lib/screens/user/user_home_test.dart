import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/cart_item.dart';
import 'package:ecommerce_app/screens/user/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserHomeTest extends StatefulWidget {
  static String id ='/userHome';

  @override
  _UserHomeTestState createState() => _UserHomeTestState();
}

class _UserHomeTestState extends State<UserHomeTest> {

  int _quantity = 1;
  GlobalKey<ScaffoldState> _scaffoldKey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context)!.settings.arguments as Product;
    print(product.name);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Product> list = Provider.of<CartItem>(context, listen: false).list;
  return Scaffold(
    key: _scaffoldKey,
     body: Column(

       children: [
         Stack(
          children: [

            Container(
          width: width,
              height: height / 3,
              child: Image.asset(product.location, fit: BoxFit.fill,),


         ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                height: MediaQuery.of(context).size.height*.1,
                alignment: Alignment.center,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, icon: Icon(Icons.arrow_back_ios), color: Colors.black,),
                    IconButton(onPressed: (){
                      Navigator.of(context).pushNamed(CartScreen.id);
                    }, icon: Icon(Icons.shopping_cart, color: Colors.black,))
                  ],
                ),
              ),
            ),

         ],
         ),
         Padding(
           padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text('Name', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),),
                   Text(product.name, style: TextStyle(color: Colors.black),)
                 ],
               ),
               Padding(
                 padding: const EdgeInsets.only(top: 20),
                 child: Column(

                   children: [
                     Text('Description', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),),
                     SizedBox(height: 10,),
                     Text(product.description)
                   ],
                 ),
               ), Padding(
                 padding: const EdgeInsets.only(top: 20),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text('Price', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),),
                     Text('\$${product.price}', style: TextStyle(color: Colors.black),)
                   ],
                 ),
               ),
             ],
             
           ),
         ),
         SizedBox(height: 50,),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             IconButton(onPressed: (){
               setState(() {
                 _quantity++;
               });
             }, icon: Icon(Icons.add, color: Colors.black,)),
             Text(_quantity.toString(), style: TextStyle(color: Colors.black, fontSize: 25),),
             IconButton(onPressed: (){
               if(_quantity >1){
                 setState(() {
                   _quantity--;
                 });
               }
             }, icon: Icon(Icons.remove, color: Colors.black,)),

           ],
         ),


         
       ],

     ),
    bottomNavigationBar: Container(
      width: width,
      height: height*.07,


      child: ElevatedButton(
          style: ButtonStyle(backgroundColor:
          MaterialStateProperty.all(kMainBackgroundColor),  shape: MaterialStateProperty.
          all(RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft:
          Radius.circular(20), topRight: Radius.circular(20))))),
          onPressed: (){

            List<Product> currentList = Provider.of<CartItem>(context, listen: false).list;
            if(currentList.isNotEmpty){
            currentList.forEach((element) {
              if(element.name == product.name ){
                ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(content: Text('Product Already Added')));
              } else{
                addProductToCart(product);

              }
            });} else{
              addProductToCart(product);

            }









          }, child: Text('ADD TO CART', style: TextStyle(color: Colors.black),)),
    ),
   );
  }


  void addProductToCart(Product product){
    var cart = Provider.of<CartItem>(_scaffoldKey.currentContext!, listen: false);
    product.setQuantity(_quantity);
    cart.addProduct(product);
    print(cart.list[0].name);
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(SnackBar(content: Text('Added to Cart')));
  }


}

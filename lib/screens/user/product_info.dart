import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/cart_item.dart';
import 'package:flutter/material.dart';



class ProductInfo extends StatefulWidget {
  static String id = '/info';

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {

  int _quantity = 2; ///setting initial quantity to 1


  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(

      body: Stack(
        children: [
          Container( ///Background image
              height: height,
              width: width,
              child: Image.asset(product.location, fit: BoxFit.fill,)),
          Padding( ///back and add to cart items
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height*.1,
              alignment: Alignment.center,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios), color: Colors.black,),
                  IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart, color: Colors.black,))
                ],
              ),
            ),
          ),
          Positioned( ///product details
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    width: width,
                    height: height*.3,

                    color: Colors.white.withOpacity(.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),), ///Name
                        SizedBox(height: 20,),
                        Text(product.description, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),), ///Desc
                        SizedBox(height: 20,),
                        Text('\$${product.price}', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),), ///Price
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(child: IconButton(onPressed: (){ ///Add button
                              setState(() {

                                ++_quantity;
                              });
                            }, icon: Icon(Icons.add), color: kMainBackgroundColor,)),
                            Text(_quantity.toString(), style: TextStyle(fontSize: 30),),
                            ClipOval(child: IconButton(onPressed: (){ ///Remove Button
                              setState(() {
                                if(_quantity > 1){ ///can't buy less than a single item
                                  --_quantity;
                                }
                              });
                            }, icon: Icon(Icons.remove), color: kMainBackgroundColor,)),

                          ],
                        )
                      ],
                    ),
                  ),
                  ButtonTheme(///Add to cart button
                    minWidth: width,
                    height: height*.12,
                    child: ElevatedButton(

                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kMainBackgroundColor)
                          ,shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(20), topRight:
                          Radius.circular(20))))),
                        onPressed: (){

                        }, child: Text('DD TO CART', style:
                    TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
            ),
          ),


        ],

      ),
    );
  }


}

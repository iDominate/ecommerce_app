import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/cart_item.dart';
import 'package:ecommerce_app/screens/user/user_home_test.dart';
import 'package:ecommerce_app/services/store.dart';
import 'package:ecommerce_app/widgets/_custom_popup_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatelessWidget {
  static String id = '/cart';


  @override
  Widget build(BuildContext context) {

    List<Product> products = Provider.of<CartItem>(context).list;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;



    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('My Cart', style: TextStyle(color: Colors.black),),
      ),

      body: products.isNotEmpty ? Column(
        children: [
          Expanded(child: ListView.builder(       itemBuilder: (context, index){
            Product currentProduct = products[index];
            return GestureDetector(
              onTapUp: (details){
                showCustomMenu(details, context, currentProduct);
              },
              child: Padding(///A single cart item
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: height*.15,
                  color: kMainBackgroundColor,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: height*.07,
                        backgroundImage: AssetImage(currentProduct.location),


                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(currentProduct.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                  SizedBox(height: 10,),
                                  Text('\$${currentProduct.price}', style: TextStyle(fontWeight: FontWeight.bold,)),
                                ],
                              ),
                            ),
                            Text(currentProduct.quantity.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );

          }, itemCount: products.length,),),
          Container(///Order Button
            width: width,
            height: height*.06,

            child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kMainBackgroundColor,)
                    , shape: MaterialStateProperty.
                    all(RoundedRectangleBorder(borderRadius:
                    BorderRadius.only(topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))))),
                onPressed: (){
                  showCustomDialog(products, context);

                }, child: Text('ORDER', style: TextStyle(color: Colors.black),)),
          )
        ],
      ) : Center(child: Text('No items added to the cart'),),
    );
  }
  void showCustomMenu(details, context, product){
    ///showing the menu in the place where the mouse right clicked
    double dx = details.globalPosition.dx;
    double dy = details.globalPosition.dy;
    double dx2 = MediaQuery.of(context).size.width -dx;
    double dy2 = MediaQuery.of(context).size.height -dy;

    showMenu(context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2), items: [
          MyPopupMenuItem(child: Text('Edit'), onClick: (){ ///a custom menu item with an
            ///onclick functionality for editing items

            Navigator.of(context).pop();
            Provider.of<CartItem>(context, listen: false).deleteProduct(product);
            Navigator.of(context).pushNamed(UserHomeTest.id, arguments: product);


          },),
          MyPopupMenuItem(child: Text('Delete'), onClick: (){ ///For deleting items
          Navigator.of(context).pop();
          Provider.of<CartItem>(context, listen: false).deleteProduct(product);
          },),
        ]);
  }

  void showCustomDialog(List<Product> products, context) async {
    int price = getTotalPrice(products);
    String address = '';
    AlertDialog dialog = AlertDialog(
      actions: [
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white,),elevation: MaterialStateProperty.all(0)),
            onPressed: (){
          storeOrders({ kTotalPrice: price, kAddress: address}, products);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ordered Successfully')));
        }, child: Text('Confirm', style: TextStyle(color: Colors.black),))
      ],
      content: TextField(
        onChanged: (value){
          address = value;
        },
        decoration: InputDecoration(hintText: 'Enter your address'),
      ),
      title: Text('Total Price = \$ ${price.toString()}'),
    );
    await showDialog(context: context, builder: (context){
      return dialog;
    });
  }

  int getTotalPrice(List<Product> products) {
    int price = 0;
    products.forEach((element) {
      price += (element.quantity * int.parse(element.price));
    });
    return price;
  }


}

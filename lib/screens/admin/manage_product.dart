import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/store.dart';
import 'package:ecommerce_app/widgets/_custom_popup_item.dart';
import 'package:flutter/material.dart';

class ManageProduct extends StatefulWidget {
  static String id ='/edit';

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: retrieveAllProducts(), ///fetching all products from database
        builder:(_, snapShot) {
          if(snapShot.hasData) { ///if data is ready load it and add it to a list
            List<Product> _products= [];
            for (var doc in snapShot.data!.docs) {
              var data = doc.data(); ///saved in a variable for multiple uses
              _products.add(Product(id:doc.id,name: data[kProductName], ///adding a product object to the list
                  price: data[kProductPrice],
                  location: data[kProductLocation],
                  category: data[kProductCategory],
                  description: data[kProductDescription]));

          }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), ///two items in a row
                itemCount: _products.length, ///number of items in a grid view
                itemBuilder: (_, i) => 
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: GestureDetector( ///enabling tap on a grid item
                        onTapUp: (details){
                          ///showing the menu in the place where the mouse right clicked
                          double dx = details.globalPosition.dx;
                          double dy = details.globalPosition.dy;
                          double dx2 = MediaQuery.of(context).size.width -dx;
                          double dy2 = MediaQuery.of(context).size.height -dy;
                          
                          showMenu(context: context,
                              position: RelativeRect.fromLTRB(dx, dy, dx2, dy2), items: [
                            MyPopupMenuItem(child: Text('Edit'), onClick: (){ ///a custom menu item with an
                              ///onclick functionality for editing items
                              Navigator.of(context).pushNamed('/add', arguments: {
                                kIsProductEdit : true, ///passing the product to AddProduct and a flag to edit the product
                                kProductIdentifier: _products[i]
                              });
                            },),
                            MyPopupMenuItem(child: Text('Delete'), onClick: (){ ///For deleting items
                              deleteProduct(_products[i].id); ///deleting the item
                              Navigator.of(context).pop(); ///hiding the menu
                            },),
                          ]);
                        },
                        child: Stack( ///A single Grid item
                          children: [
                            Positioned.fill(child:Image.asset(_products[i].location,fit: BoxFit.fill,), ),
                            Positioned(bottom: 0,
                                  child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              color: Colors.white.withOpacity(.6),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(_products[i].name), ///Product name
                                          Text('\$${_products[i].price}') ///Product Price
                                        ],
                                      ),
                                    ),
                            ),
                                )


                          ],
                        ),
                      ),
                    )
            );
          } else {
            ///if data is not ready, show a progressbar
            return CircularProgressIndicator();
        }
        }
      ),
    );
  }


}


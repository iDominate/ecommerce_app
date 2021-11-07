import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/user/user_home_test.dart';
import 'package:ecommerce_app/services/store.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


class CustomTabView extends StatelessWidget {
  final String category;

  CustomTabView({required this.category});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: retrieveProductByCategory(category),

        ///fetching all products from database
        builder: (_, snapShot) {
          if (snapShot.hasData) {
            ///if data is ready load it and add it to a list
            List<Product> _products = [];
            for (var doc in snapShot.data!.docs) {
              var data = doc.data();

              ///saved in a variable for multiple uses
              if(data[kProductCategory] == category){
                _products.add(Product(id: doc.id,
                    name: data[kProductName],

                    ///adding a product object to the list
                    price: data[kProductPrice],
                    location: data[kProductLocation],
                    category: data[kProductCategory],
                    description: data[kProductDescription]));
              }



            }
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),

                ///two items in a row
                itemCount: _products.length,

                ///number of items in a grid view
                itemBuilder: (_, i) =>
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: GestureDetector(

                        ///enabling tap on a grid item
                        onTap: (){
                          ///navigate to ProductInfo
                          Navigator.of(context).pushNamed(UserHomeTest.id, arguments: _products[i]);
                        },
                        child: Stack(

                          ///A single Grid item
                          children: [
                            Positioned.fill(child: Image.asset(
                              _products[i].location, fit: BoxFit.fill,),),
                            Positioned(bottom: 0,
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 60,
                                color: Colors.white.withOpacity(.6),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(_products[i].name),

                                      ///Product name
                                      Text('\$${_products[i].price}')

                                      ///Product Price
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
    );
  }
}

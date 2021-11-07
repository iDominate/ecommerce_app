import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/store.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  static String id = '/orderDetails';

  @override
  Widget build(BuildContext context) {
    String docId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(builder: (_, snapshot){

        if(snapshot.hasData){
         List<Product> list = [];
         snapshot.data!.docs.forEach((element) {
           Map<String, dynamic> data = element.data() as Map<String, dynamic>;
           list.add(Product(name: data[kProductName], quantity: data[kQuantity], category: data[kProductCategory]));


         });
         return Column(
           children: [
             Expanded(
               child: ListView.builder(
                 itemCount: list.length,
                 itemBuilder: (_, index) => Padding(
                   padding: EdgeInsets.all(20),
                   child: Container(
                     height: MediaQuery.of(context).size.height *.2,
                     color: kSecondaryColor,
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text('Total Name : ${list[index].name}',
                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                           SizedBox(height: 10,),
                           Text('Quantity : ${list[index].quantity}',
                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                           SizedBox(height: 10,),
                           Text('Category : ${list[index].category}',
                             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                         ],
                       ),
                     ),

                   ),
                 ),
               ),
             ),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 10),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Expanded(
                     child: ElevatedButton(onPressed: (){}, child: Text('Confirm', style: TextStyle(color: Colors.black),),
                       style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kMainBackgroundColor)),),
                   ),
                   SizedBox(width: 10,),
                   Expanded(
                     child: ElevatedButton(onPressed: (){}, child: Text('Delete', style: TextStyle(color: Colors.black),),
                       style: ButtonStyle(backgroundColor: MaterialStateProperty.all(kMainBackgroundColor)),),
                   ),
                 ],
               ),
             ),

           ],
         );
        } else {
          return Center(child: Text('Loading Order ...'),);
        }

      }, stream: loadOrderDetails(docId),),
    );
  }
}

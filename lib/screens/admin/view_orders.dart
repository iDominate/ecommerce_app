import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/screens/admin/order_details.dart';
import 'package:ecommerce_app/services/store.dart';
import 'package:flutter/material.dart';

class ViewOrders extends StatelessWidget {
  static String id = '/view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: loadOrders(),
        builder: (_ , snapshot){
          if(!snapshot.hasData){
            return Center(child: Text('There are no orders'),);
          } else{
            List<Order> orders = [];
            
            for(QueryDocumentSnapshot doc in snapshot.data!.docs){
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              orders.add(Order(documentId: doc.id, address: data[kAddress], totalPrice: data[kTotalPrice].toString()));
            }

            return ListView.builder(itemBuilder: (_, index){
              Order currentOrder = orders[index];
              return InkWell(
                onTap: (){

                  Navigator.of(context).pushNamed(OrderDetails.id, arguments: currentOrder.documentId);
                },
                child: Padding(
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
                          Text('Total Price = \$ ${currentOrder.totalPrice}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Text('Address is ${currentOrder.address}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),

                  ),
                ),
              );
            }, itemCount: orders.length,);
          }
        },
      ),
    );
  }
}

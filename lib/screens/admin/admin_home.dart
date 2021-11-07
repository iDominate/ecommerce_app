import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/admin/manage_product.dart';
import 'package:ecommerce_app/screens/admin/view_orders.dart';
import 'package:ecommerce_app/widgets/custom_admin_button.dart';
import 'package:flutter/material.dart';


class AdminHome extends StatelessWidget {
  static String id = '/adminHome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(function: (){
              Navigator.of(context).pushNamed('/add');
    }, content: 'Add Product',),
            CustomButton(content: 'Edit Product', function: (){
              ///Navigate to edit product screen
              Navigator.of(context).pushNamed(ManageProduct.id);
            }),
            CustomButton(content: 'View Orders', function: (){
              Navigator.of(context).pushNamed(ViewOrders.id);
            })
    ]
    ),
      ));
  }
}

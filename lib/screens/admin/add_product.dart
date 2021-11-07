import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/store.dart';
import 'package:ecommerce_app/widgets/custom_admin_text_field.dart';
import 'package:ecommerce_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';



class AddProduct extends StatelessWidget {
  static String id = '/add';
  ///variables for user input
  late String _name, _price, _description, _category, _location;

  final GlobalKey<FormState> _formState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Map<dynamic, dynamic> data = ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      body: Form(
        key: _formState,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAdminTextField(hint: 'Product Name', name: 'Name', function: (value){
              _name = value!;
            }),
            SizedBox(height: height*.01,),
            CustomAdminTextField(hint: 'Product Price',  name: 'Price',  function: (value){
              _price = value!;
            }),
            SizedBox(height: height*.01,),
            CustomAdminTextField(hint: 'Product Description', name: 'Description',  function: (value){
              _description = value!;
            }),
            SizedBox(height: height*.01,),
            CustomAdminTextField(hint: 'Product Category', name: 'Category',  function: (value){
        _category = value!;
        }),
            SizedBox(height: height*.01,),
            CustomAdminTextField(hint: 'Product Location', name: 'Location',  function: (value){
              _location = value!;
            }),
            SizedBox(height: height*.04,),
            ElevatedButton(onPressed: (){
              ///Ensuring user input is valid
              if(_formState.currentState!.validate()){
                ///saving user input to variables
                _formState.currentState!.save();
                ///creating a Product instance for variables and saving it on FireStore
                if(data[kIsProductEdit] != null && (data[kIsProductEdit] as bool)){
                  editProduct(Product(name: _name, price: _price, location: _location,
                      category: _category, description: _description,
                      id: (data[kProductIdentifier] as Product).id));
                } else{
                  addProduct(Product(name: _name, price: _price, location: _price,
                      category: _category, description: _description, id: UniqueKey().toString()));
                }

              }
            }, child: Text(data[kIsProductEdit] != null ?'Edit product' : 'Add Product', style: TextStyle(color: Colors.white),),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.
                  all(RoundedRectangleBorder(borderRadius:
                  BorderRadius.circular(20)))),)

          ],
        ),
      ),
    );
  }
}

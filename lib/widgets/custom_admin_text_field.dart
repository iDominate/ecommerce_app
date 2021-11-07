import 'package:flutter/material.dart';

import 'package:ecommerce_app/constants.dart' as k;


///Custom text field for the admin panel
class CustomAdminTextField extends StatelessWidget {
  final String hint;

  final String name;
  final Function(String?) function;


  CustomAdminTextField({required this.hint, required this.name, required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: TextFormField(
        ///if name if Password obscure text
        obscureText: name == 'Password'? true : false,
        onSaved: function,

        validator: (value){
          if(value!.isEmpty){

            return '$name Field can\'t be empty';
          }

          return null;
        },
        cursorColor: k.kMainBackgroundColor, ///cursor color
        decoration: InputDecoration(
            hintText: hint,


            filled: true, ///whether it has a fill color
            fillColor: k.kSecondaryColor, ///fill color
            border: OutlineInputBorder(

                borderRadius: BorderRadius.circular(20),///border radius
                borderSide: BorderSide(color: Colors.white)///border color
            )
        ),
      ),
    );
  }
}

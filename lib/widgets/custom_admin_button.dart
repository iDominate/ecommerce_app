import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String content;
  Function() function;

  CustomButton({required this.content, required this.function});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: function, child: Text(content,
      style: TextStyle(color: Colors.white),)
      , style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.black)
    ),);
  }
}

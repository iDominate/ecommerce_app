import 'package:flutter/material.dart';

class CustomLogoWidget extends StatelessWidget {
  const CustomLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(40.0),
      child: Container(

        height: MediaQuery.of(context).size.height*.1,
        child: Stack(
          ///image and Text
          alignment: Alignment.center,
          children: [
            Image.asset('images/icons/buyicon.png',height: 300, width: 300,),
            Positioned(
                bottom: 0

                ,child:
            Text('Buy it', style: TextStyle(fontFamily: 'Pacifico'),))
          ],
        ),
      ),

    );
  }
}

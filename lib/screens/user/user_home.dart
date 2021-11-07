import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/screens/user/cart_screen.dart';
import 'package:ecommerce_app/services/auth.dart';

import 'package:ecommerce_app/services/store.dart';
import 'package:ecommerce_app/widgets/custom_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserHome extends StatefulWidget {
  static String id = '/home';


  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int _tabIndex = 0;
  int _bottomIndex = 0;
  List<Product> _products = [];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [DefaultTabController(length: 4, child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex:_bottomIndex ,
          unselectedItemColor: kInactiveColor,
          fixedColor: kMainBackgroundColor,
          onTap: (value) async{
            if(value == 2){
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              signOutUSer();
              Navigator.of(context).popAndPushNamed(LoginScreen.id);

            }
            setState(() {
              _bottomIndex = value;
            });
          },
          items: [

            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Test'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Test'),
            BottomNavigationBarItem(icon: Icon(Icons.close), label: 'Sign out'),
          ],
        ),
        appBar: AppBar(


          backgroundColor: Colors.white,
          elevation: 0,


          bottom: TabBar(


            indicatorColor: kMainBackgroundColor,
            onTap: (value){
              setState(() {
                _tabIndex = value;
              });
            },
            tabs: [
              Text('Jackets', style: TextStyle(color:
              _tabIndex == 0 ? Colors.black : kInactiveColor, fontSize: _tabIndex == 0 ? 16 : null )),
              Text('Trousers', style: TextStyle(color:
              _tabIndex == 1 ? Colors.black : kInactiveColor, fontSize: _tabIndex == 1 ? 16 : null )),
              Text('T-Shirts', style: TextStyle(color:
              _tabIndex == 2 ? Colors.black : kInactiveColor, fontSize: _tabIndex == 2 ? 16 : null )),
              Text('Shoes', style: TextStyle(color:
              _tabIndex == 3 ? Colors.black : kInactiveColor, fontSize: _tabIndex == 3 ? 16 : null ))
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CustomTabView(category: kJackets),
            CustomTabView(category: kTrousers),
            CustomTabView(category: kTShirts),
            CustomTabView(category: kShoes),

          ],
        ),
      )),
        Material(

          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height*.1,
              alignment: Alignment.center,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('DISCOVER', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
                  IconButton(onPressed: (){
                    Navigator.of(context).pushNamed(CartScreen.id);
                  }, icon: Icon(Icons.shopping_cart, color: Colors.black,))
                ],
              ),
            ),
          ),
        )
    ]
    );
  }








}


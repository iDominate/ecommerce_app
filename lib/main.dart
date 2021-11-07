import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/providers/admin_state_provider.dart';
import 'package:ecommerce_app/providers/cart_item.dart';
import 'package:ecommerce_app/providers/model_hud_provider.dart';
import 'package:ecommerce_app/screens/admin/add_product.dart';
import 'package:ecommerce_app/screens/admin/admin_home.dart';
import 'package:ecommerce_app/screens/admin/manage_product.dart';
import 'package:ecommerce_app/screens/admin/order_details.dart';
import 'package:ecommerce_app/screens/admin/view_orders.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/screens/signup_screen.dart';
import 'package:ecommerce_app/screens/user/cart_screen.dart';
import 'package:ecommerce_app/screens/user/product_info.dart';
import 'package:ecommerce_app/screens/user/user_home.dart';
import 'package:ecommerce_app/screens/user/user_home_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


main(){
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  bool _isUserLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    ///Initializing Firebase
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    ///initializing app wrapping it inside MultiProvider for later use
    return FutureBuilder<SharedPreferences>(builder: (_, snapshot){
      if(snapshot.hasData){
      _isUserLoggedIn =  snapshot.data!.getBool(kKeepMeLoggedIn) ?? false;
        return MultiProvider(
          providers: [
            ///for changing the state of the progress indicator
            ChangeNotifierProvider(
              create: (_) => ModuleHudProvider(),),
            ///for toggling between User and Admin
            ChangeNotifierProvider(create: (_) => AdminStateProvider()),
            ChangeNotifierProvider<CartItem>(create: (_) => CartItem()) ///For keeping track of Products added to cart
          ],

          child: MaterialApp(
            ///LoginScreen to launched at app start
            initialRoute: _isUserLoggedIn ? UserHome.id : LoginScreen.id,
            //first screen
            //Named routes
            routes: {
              OrderDetails.id: (_) => OrderDetails(),
              ViewOrders.id: (_) => ViewOrders(),
              CartScreen.id: (_) => CartScreen(),
              UserHomeTest.id: (_) => UserHomeTest(),
              LoginScreen.id: (_) => LoginScreen(),
              SignupScreen.id: (_) => SignupScreen(),
              AddProduct.id: (_) => AddProduct(),
              AdminHome.id: (_) => AdminHome(),
              UserHome.id: (_) => UserHome(),
              ManageProduct.id: (_) => ManageProduct()
            }, // routes
          ),
        );
      } else {

        return MaterialApp(home: Center(child: Text('Loading ...'),),);
      }
    });


  }
}

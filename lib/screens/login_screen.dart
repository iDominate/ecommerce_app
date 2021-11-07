import 'package:ecommerce_app/constants.dart' as k;
import 'package:ecommerce_app/providers/admin_state_provider.dart';
import 'package:ecommerce_app/providers/model_hud_provider.dart';
import 'package:ecommerce_app/screens/admin/admin_home.dart';
import 'package:ecommerce_app/screens/signup_screen.dart';
import 'package:ecommerce_app/screens/user/user_home.dart';
import 'package:ecommerce_app/services/auth.dart';
import 'package:ecommerce_app/widgets/custom_text_field.dart';
import 'package:ecommerce_app/widgets/cutom_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  //static variable to be used in initial route and the routes map
  static String id = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isRememberMeChecked = false;

  String? _email, _password;

  String _adminPassword = 'admin1234';

  ///variable to get the context of scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: k.kMainBackgroundColor,
      body: Builder(
        builder: (context) => ModalProgressHUD( //TODO: change to Normal progress Indicator
          inAsyncCall:
              Provider.of<ModuleHudProvider>(_scaffoldKey.currentContext!)
                  .isLoading,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                CustomLogoWidget(),
                SizedBox(
                  height: height * .1,
                ),

                ///Email Field
                CustomTextField(
                  hint: 'Enter your email',
                  icon: Icons.email,
                  name: 'Email',
                  function: (value) {
                    _email = value!;
                  },
                ),
                SizedBox(height: 10,),
                ///Remember Me option
                Padding(padding: EdgeInsets.only(left: 20), child: Row(

                  children: [
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(

                        checkColor: k.kSecondaryColor,
                          activeColor: k.kMainBackgroundColor,
                          value: _isRememberMeChecked, onChanged: (value){
                        setState(() {
                          _isRememberMeChecked = value!;
                        });
                      }),
                    ),
                    Text('Remember Me?', style: TextStyle(color: Colors.black),)
                  ],
                ),),
                SizedBox(
                  height: height * .02,
                ),

                ///Password Field
                CustomTextField(
                  hint: 'Enter your password',
                  icon: Icons.lock,
                  name: 'Password',
                  function: (value) {
                    _password = value!;
                  },
                ),
                SizedBox(
                  height: height * .05,
                ),

                ///Login Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),

                        ///rounded corners
                      ),
                      onPressed: () {
                        ///Line 153
                        if(_isRememberMeChecked){
                          keepUserLoggedIn();
                        }
                        _validateAndSignIn(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: height * .05,
                ),

                ///Sign up text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(SignupScreen.id);

                          ///moving to SignupScreen when pressed
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(fontSize: 16),
                        ))
                  ],
                ),
                SizedBox(
                  height: height * .01,
                ),
                ///toggle between user and admin
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Provider.of<AdminStateProvider>(context, listen: false).changeAdminState(true);
                      },
                      child: Text(
                        'I\'m an Admin',
                        style: TextStyle(
                            color:
                                Provider.of<AdminStateProvider>(context).isAdmin ? k.kMainBackgroundColor : Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Provider.of<AdminStateProvider>(context, listen: false).changeAdminState(false);
                      },
                      child: Text(
                        'I\'m a User',
                        style: TextStyle(
                            color:
                            Provider.of<AdminStateProvider>(context).isAdmin? Colors.white : k.kMainBackgroundColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateAndSignIn(BuildContext context) async{
    final provider = Provider.of<ModuleHudProvider>(
        _scaffoldKey.currentContext!,
        listen: false);
    provider.changeLoadingState(true); ///showing progress indicator

    ///Signing in user
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); ///saving user input to variables
      if(Provider.of<AdminStateProvider>(_scaffoldKey.currentContext!, listen: false).isAdmin){
        if(_password == _adminPassword){
          try{
            ///Block for signing user as Admin
            await signInUser(_email!.trim(), _adminPassword); ///Sign in user as Admin
            provider.changeLoadingState(false); ///hiding progress indicator
            ///TODO: Implement navigation to AdminHome
            Navigator.of(context).pushNamed(AdminHome.id);


          } catch(e){
            provider.changeLoadingState(false);///hiding progress indicator
            print(e); ///For debugging purposes
            ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(

                SnackBar(content: Text('Something went wrong'),)
            ); ///Showing a snack bar
          }
        } else{
          provider.changeLoadingState(false);///hiding progress indicator
        ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
            SnackBar(content: Text('You are a normal user'))
        );
          ///Block for signing user as normal User

        }
      } else{
        try {


          ///Sign in as normal user
          provider.changeLoadingState(false);///hiding progress indicator



          Navigator.pushNamed(context, UserHome.id);
        } on PlatformException catch(e){
          provider.changeLoadingState(false);///hiding progress indicator
          print(e.toString()); ///For debugging purposes
          ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(

              SnackBar(content: Text(e.message!),));
        }
      }


    } else{

    provider.changeLoadingState(false);

    ///hiding progress indicator if validation fails
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
    SnackBar(content: Text('Input fields are empty'))
    );

    }
  }

  void keepUserLoggedIn() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(k.kKeepMeLoggedIn, _isRememberMeChecked);
  }
}



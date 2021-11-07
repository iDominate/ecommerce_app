import 'package:ecommerce_app/providers/model_hud_provider.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/services/auth.dart';
import 'package:ecommerce_app/widgets/cutom_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/constants.dart' as k;
import 'package:ecommerce_app/widgets/custom_text_field.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  ///name of screen for routing
  static String id = '/signup';

  final GlobalKey<FormState> _formKey = GlobalKey();
  String? _email, _password, _name;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: k.kMainBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModuleHudProvider>(_scaffoldKey.currentContext!).isLoading,
        child: Form(
          key: _formKey,
          child: ListView(

            children: [

              ///Logo
              CustomLogoWidget(),
              SizedBox(height: height * .1,),

              ///Name Field
              CustomTextField(hint: 'Enter your name',
                icon: Icons.person,
                name: 'Name',
                function: (value) {
                  print('name: $_name');
                  _name = value!;
                },),
              SizedBox(height: height * .02,),

              ///Email Field
              CustomTextField(hint: 'Enter your email',
                icon: Icons.email,
                name: 'Email',
                function: (value) {
                  print('Email: $_email');
                  _email = value!;
                },),
              SizedBox(height: height * .02,),

              ///Password Field
              CustomTextField(hint: 'Enter your password',
                icon: Icons.lock,
                name: 'Password',
                function: (value) {
                print('Password: $_password');
                  _password = value!;
                },),
              SizedBox(height: height * .05,),

              ///Signup Button
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
                      final provider = Provider.of<ModuleHudProvider>(_scaffoldKey.currentContext!, listen: false);
                      provider.changeLoadingState(true);
                      ///Signing up user
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        try {
                          signUpUser(_email!, _password!);
                          provider.changeLoadingState(false);
                        } on PlatformException catch (e) {
                          provider.changeLoadingState(false);
                          ScaffoldMessenger.of(_scaffoldKey.currentContext!)
                              .showSnackBar(
                            SnackBar(content: Text(e.message!))
                          );
                        }
                      }
                      provider.changeLoadingState(false);
                    }
                    ,
                    child: Text(
                      'Signup', style: TextStyle(color: Colors.white),)),
              ),
              SizedBox(height: height * .05,),

              ///Sign up text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('already have an account? ',
                    style: TextStyle(color: Colors.white, fontSize: 16),),
                  InkWell(onTap: () {
                    Navigator.of(context).pushNamed(LoginScreen.id);

                    ///moving to LoginScreen when pressed
                  }, child: Text('Login', style: TextStyle(fontSize: 16),))
                ],
              )


            ],


          ),
        ),
      ),
    );
  }
}

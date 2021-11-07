import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
///A file for authentication purposes

///Sign in user
    signInUser(String email,String password){
  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
  .then((value) {
    Fluttertoast.showToast(msg: 'Login Success');
  })
  ;
}


///Signup user
signUpUser(String email,String password){
  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) {
    Fluttertoast.showToast(msg: 'Sign up Success');
  })
  ;
}

signOutUSer(){
      FirebaseAuth.instance.signOut();
}


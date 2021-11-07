import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


///A provider for toggling between User and Admin
class AdminStateProvider with ChangeNotifier{
  bool isAdmin = false;

  changeAdminState(bool newState){
    isAdmin = newState;
    notifyListeners();
  }
}
import 'package:flutter/cupertino.dart';


//a provider for changing the state of the progress indicator
class ModuleHudProvider with ChangeNotifier{
  bool isLoading = false;

  //changes the state of isLoading and notifies listeners for rebuilding
  changeLoadingState(bool newState){
    isLoading = true;
    notifyListeners();
  }
}
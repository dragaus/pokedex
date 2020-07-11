import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier{
  bool isAuth = false;

  void setAuth(bool value){
    isAuth = value;
    notifyListeners();
  }
}
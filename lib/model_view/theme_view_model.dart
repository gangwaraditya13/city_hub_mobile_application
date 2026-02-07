import 'package:city_hub/resource/Theams/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeViewModel with ChangeNotifier{

  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData value) {
    _themeData = value;
    notifyListeners();
  }

  void toggleTheme(){
    if(themeData == lightMode){
      themeData = darkMode;
    }else{
      themeData = lightMode;
    }
  }
}
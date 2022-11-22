import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {

  bool _darkThemeMode = true;

  AppThemeProvider();

  bool get darkThemeMode => _darkThemeMode;

  void setDarkThemeMode({bool isDarkThemeEnabled = true, bool isNotify = true}) {
    _darkThemeMode = isDarkThemeEnabled;
    if(isNotify) notifyListeners();
  }

  void resetThemeMode({bool isNotify = true}) {
    _darkThemeMode = true;
    if(isNotify) notifyListeners();
  }
}
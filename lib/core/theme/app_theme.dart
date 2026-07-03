import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  // final ThemeData lightTheme = ThemeData.light().copyWith(
  //   primaryTextTheme: TextTheme(bodySmall: TextStyle(color: Colors.white)),
  //   textTheme: TextTheme(bodySmall: TextStyle(color: Colors.black)),
  // );
  // final ThemeData darkTheme = ThemeData.dark().copyWith(
  //   primaryTextTheme: TextTheme(bodySmall: TextStyle(color: Colors.black)),
  //   textTheme: TextTheme(bodySmall: TextStyle(color: Colors.white)),
  // );
}

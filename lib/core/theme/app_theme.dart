import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0XFF5D9CEC);

  static ThemeData lightTheme = ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Color(0XFFDFECDB),
      appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: primaryColor,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          )),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.transparent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(color: primaryColor, size: 30),
          unselectedIconTheme: IconThemeData(color: Colors.grey, size: 30)));
}

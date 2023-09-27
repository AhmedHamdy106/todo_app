import 'package:flutter/material.dart';

class AppTheme {
  static Color lightPrimary = const Color(0XFF5D9CEC);
  static ThemeMode themeMode = ThemeMode.dark;

  static ThemeData lightTheme = ThemeData(
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: Color(0XFFDFECDB),
    appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color(0XFF5D9CEC),
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
        selectedIconTheme: IconThemeData(color: lightPrimary, size: 30),
        unselectedIconTheme: IconThemeData(color: Colors.grey, size: 30)),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 30.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 25.0,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
          fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
    ),
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Color(0XFFDFECDB),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ))),
  );
  static ThemeData darkTheme = ThemeData(
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: Color(0XFF060E1E),
    appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Color(0XFF5D9CEC),
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Color(0XFF060E1E),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(color: lightPrimary, size: 30),
        unselectedIconTheme: IconThemeData(color: Colors.grey, size: 30)),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 30.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 25.0,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
          fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
    ),
    bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Color(0XFF141922),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ))),
  );
}

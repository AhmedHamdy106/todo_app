import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String CurrentLanguage = "en";

  selectArabicLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", "ar");
    CurrentLanguage = "ar";
    notifyListeners();
  }

  selectEnglishLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", "en");
    CurrentLanguage = "en";
    notifyListeners();
  }

  enableDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("theme", !isDark() ? true : false);
    themeMode = ThemeMode.dark;
    notifyListeners();
  }

  enableLightTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("theme", isDark() ? true : false);
    themeMode = ThemeMode.light;
    notifyListeners();
  }

  bool isDark() {
    return themeMode == ThemeMode.dark;
  }

  // String selectBackground() {
  //   if (isDark()) {
  //     notifyListeners();
  //     return "assets/images/background_dark.png";
  //   } else {
  //     notifyListeners();
  //     return "assets/images/background_light.png";
  //   }
  // }
  getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CurrentLanguage = prefs.getString("lang")!;
    notifyListeners();
  }

  Future<void> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDark = prefs.getBool("theme");

    if (isDark != null) {
      themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  String selectBackground() {
    if (isDark()) {
      notifyListeners();
      return "assets/images/background_dark.png";
    } else {
      notifyListeners();
      return "assets/images/background_light.png";
    }
  }
}

// String selectBackground() {
//   if (isDark()) {
//     notifyListeners();
//     return "assets/images/background_dark.png";
//   } else {
//     notifyListeners();
//     return "assets/images/background_light.png";
//   }
// }

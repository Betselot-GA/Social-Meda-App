import 'package:flutter/material.dart';
import 'package:social_media/theme/dark_mode.dart';
import 'package:social_media/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  bool get isDarkMode => _themeData == darkMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;

    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
     // Notify listeners to rebuild the UI with the updated theme
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  get themeMode => _themeMode;

  toggleTheme(bool isDark) {
    debugPrint('toggle theme...');
    _themeMode = isDark ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }

}
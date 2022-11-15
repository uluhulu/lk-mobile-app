import 'package:flutter/material.dart';

enum MyThemeMode {
  system,
  light,
  dark,
}

extension MyThemeModeExtension on MyThemeMode {
  ThemeMode get themeMode {
    switch (this) {
      case MyThemeMode.system:
        return ThemeMode.system;
      case MyThemeMode.light:
        return ThemeMode.light;
      case MyThemeMode.dark:
        return ThemeMode.dark;
    }
  }

  int get index {
    switch (this) {
      case MyThemeMode.system:
        return 0;
      case MyThemeMode.light:
        return 1;
      case MyThemeMode.dark:
        return 2;
    }
  }

  static MyThemeMode fromIndex(int index) {
    switch (index) {
      case 0:
        return MyThemeMode.system;
      case 1:
        return MyThemeMode.light;
      case 2:
        return MyThemeMode.dark;
      default:
        return MyThemeMode.system;
    }
  }
}

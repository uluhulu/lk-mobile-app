import 'package:flutter/material.dart';

/// Цвета
abstract class AppColors {
  /// SYSTEM
  late Color primaryColor;

  late Color accentColor;

  late Color splashColor;

  late Color scaffoldBackgroundColor;

  late Color primaryButtonColor;

  late Color secondaryButtonColor;

  late Color spaceGray;

  Color? appBarColor;

  Color? tabBarColor;

  Color? tabBarSelectedColor;

  Color? tabBarNormalColor;

  Brightness? brightness;

  ColorScheme? colorScheme;

  Color? dividerColor;

  /// CUSTOMS
  Color? cardColor;

  Color? textColor;

  Color? whiteTextColor;
}

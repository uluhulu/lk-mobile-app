import 'package:flutter/material.dart';

import '../../elements/app_colors.dart';

///
class AppColorsLight implements AppColors {
  /// SYSTEM
  @override
  Color? appBarColor;

  @override
  Brightness? brightness = Brightness.light;

  @override
  ColorScheme? colorScheme = const ColorScheme.light();

  @override
  Color scaffoldBackgroundColor = const Color.fromRGBO(245, 245, 245, 1);

  @override
  Color? tabBarColor;

  @override
  Color? tabBarNormalColor;

  @override
  Color? tabBarSelectedColor;

  @override
  Color primaryColor = const Color.fromARGB(255, 39, 52, 148);

  @override
  Color accentColor = const Color(0xff777878);

  @override
  Color splashColor = const Color.fromRGBO(242, 243, 244, 1);

  @override
  Color? dividerColor = const Color.fromARGB(255, 199, 196, 196);

  /// CUSTOM
  @override
  Color? cardColor = Colors.white;

  @override
  //#0E0E0E
  Color? textColor = const Color.fromARGB(255, 14, 14, 14);

  @override
  Color primaryButtonColor = const Color.fromARGB(255, 39, 52, 148);

  @override
  Color secondaryButtonColor = const Color.fromARGB(255, 236, 242, 250);

  @override
  Color spaceGray = const Color.fromARGB(255, 96, 96, 96);

  @override
  Color? whiteTextColor = Colors.white;
}

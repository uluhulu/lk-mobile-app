import 'package:flutter/material.dart';
import '../elements/app_colors.dart';
import '../elements/app_text_theme.dart';

///
class AppTextThemeImpl implements AppTextTheme {
  AppTextThemeImpl(this.appColors) {
    headline2 = TextStyle(
      color: appColors.textColor,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    );
    headline3 = TextStyle(
      color: appColors.textColor,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    headline4 = TextStyle(
      color: appColors.textColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    bodyText1 = TextStyle(
      fontSize: 16.0,
      color: appColors.textColor,
      fontWeight: FontWeight.w400,
    );
    subtitle1 = TextStyle(
      fontSize: 16.0,
      color: appColors.textColor,
      fontWeight: FontWeight.w400,
    );
    subtitle2 = TextStyle(
      fontSize: 16.0,
      color: appColors.spaceGray,
      fontWeight: FontWeight.w400,
    );
    bodyText2 = TextStyle(
      fontSize: 14.0,
      color: appColors.textColor,
    );
    headline5 = TextStyle(
      color: appColors.textColor,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
  }

  final AppColors appColors;

  @override
  TextStyle? bodyText1;

  @override
  TextStyle? bodyText2;

  @override
  String? fontFamily;

  @override
  TextStyle? headline1;

  @override
  TextStyle? headline3;

  @override
  TextStyle? headline5;

  @override
  TextStyle? subtitle1;

  @override
  TextStyle? subtitle2;

  @override
  TextStyle? headline2;

  @override
  TextStyle? headline4;
}

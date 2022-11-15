// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../themes/light/my_theme_data_light.dart';

class MyTheme extends StatelessWidget {
  final MyThemeData data;
  final Widget child;
  const MyTheme({Key? key, required this.data, required this.child})
      : super(key: key);
  static final MyThemeData _kFallbackTheme = MyThemeData.fallback();
  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(
      theme: data,
      child: child,
    );
  }

  static MyThemeData of(BuildContext context) {
    final _InheritedTheme? inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    final MyThemeData theme = inheritedTheme?.theme ?? _kFallbackTheme;
    return theme;
  }
}

class _InheritedTheme extends InheritedTheme {
  const _InheritedTheme({
    Key? key,
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  final MyThemeData theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MyTheme(data: theme, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedTheme old) {
    final ok = theme != old.theme;
    return ok;
  }
}

abstract class MyThemeData {
  factory MyThemeData.fallback() => MyThemeData.light();
  factory MyThemeData.light() => MyThemeDataLight();

  late Color primaryColor;
  late Color splashScreenColor;
  late Color primaryButtonColor;
  late Color secondaryButtonColor;
  late Color greenColor;
  late Color redColor;
  late Color whiteColor;
  late Color hintColor;
  late Color greyIconColor;
  late Color emailIconColor;
  late Color phoneIconColor;
  late Color errorColor;
  late Color successColor;
  late Color paymentsCardColor;
  late Color blueColor;
  late Color orangeColor;

  @override
  bool operator ==(covariant MyThemeData other) {
    if (identical(this, other)) return true;

    return other.primaryColor == primaryColor &&
        other.splashScreenColor == splashScreenColor &&
        other.primaryButtonColor == primaryButtonColor &&
        other.secondaryButtonColor == secondaryButtonColor &&
        other.greenColor == greenColor &&
        other.redColor == redColor &&
        other.whiteColor == whiteColor &&
        other.hintColor == hintColor &&
        other.greyIconColor == greyIconColor &&
        other.emailIconColor == emailIconColor &&
        other.phoneIconColor == phoneIconColor &&
        other.errorColor == errorColor &&
        other.successColor == successColor &&
        other.paymentsCardColor == paymentsCardColor;
  }

  @override
  int get hashCode {
    return primaryColor.hashCode ^
        splashScreenColor.hashCode ^
        primaryButtonColor.hashCode ^
        secondaryButtonColor.hashCode ^
        greenColor.hashCode ^
        redColor.hashCode ^
        whiteColor.hashCode ^
        hintColor.hashCode ^
        greyIconColor.hashCode ^
        emailIconColor.hashCode ^
        phoneIconColor.hashCode ^
        errorColor.hashCode ^
        successColor.hashCode ^
        paymentsCardColor.hashCode;
  }
}
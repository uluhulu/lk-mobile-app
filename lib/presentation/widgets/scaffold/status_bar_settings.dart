import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../services/platform.dart';

class StatusBarSettings {
  static SystemUiOverlayStyle settings(BuildContext context) {
    return SystemUiOverlayStyle(
      statusBarIconBrightness: isApple() ? Brightness.dark : Brightness.light,
      statusBarBrightness: isApple() ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          isApple() ? Brightness.dark : Brightness.light,
      statusBarColor: const Color.fromARGB(255, 39, 52, 148),
      systemNavigationBarColor: isApple()
          ? const Color.fromARGB(255, 255, 255, 255)
          : Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true,
      systemStatusBarContrastEnforced: true,
    );
  }
}

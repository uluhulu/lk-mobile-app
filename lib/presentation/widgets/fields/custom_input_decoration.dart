import 'package:flutter/material.dart';

import '../../../config/theme/elements/theme_data.dart';
import '../../../core/utils/constants.dart';

class CustomInputDecoration extends InputDecoration {
  final bool? needOtherFocusColor;
  final MyThemeData myColors;
  CustomInputDecoration({
    required String hintText,
    required this.myColors,
    this.needOtherFocusColor,
    Widget? suffixIcon,
    TextStyle? hintStyle,
  }) : super(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
              borderSide: BorderSide(color: myColors.hintColor, width: 1)),
          focusedBorder: needOtherFocusColor == null
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  borderSide:
                      BorderSide(color: myColors.primaryButtonColor, width: 1))
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kBorderRadius),
                  borderSide: BorderSide(color: myColors.hintColor, width: 1)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
              borderSide: const BorderSide(color: Colors.red, width: 1)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
              borderSide: BorderSide(color: myColors.hintColor, width: 1)),
          hintText: hintText,
          hintStyle: hintStyle ??
              TextStyle(
                fontSize: 16,
                color: myColors.hintColor,
              ),
          suffixIcon: suffixIcon,
          suffixIconConstraints: const BoxConstraints(
            minHeight: 24,
            minWidth: 48,
          ),
          labelStyle: const TextStyle(fontSize: 16),
          errorMaxLines: 8,
        );
}

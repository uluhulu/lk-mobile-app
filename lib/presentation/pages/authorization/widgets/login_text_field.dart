// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mkk/config/theme/elements/theme_data.dart';
import 'package:mkk/generated/l10n.dart';
import '../../../widgets/fields/custom_input_decoration.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final Function(String)? onChanged;
  const LoginTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.textType,
    this.suffixIcon,
    this.validator,
    this.obscureText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      validator: validator,
      controller: controller,
      keyboardType: textType,
      decoration: CustomInputDecoration(
        hintText: S.of(context).enter_login,
        myColors: myColors,
      ),
    );
  }
}

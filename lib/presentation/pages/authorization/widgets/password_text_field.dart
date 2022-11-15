// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/fields/custom_input_decoration.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  bool? obscureText;
  final Function(String)? onChanged;
  PasswordTextField({
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
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return TextFormField(
      onChanged: widget.onChanged,
      obscureText: widget.obscureText ?? false,
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.textType,
      decoration: CustomInputDecoration(
        suffixIcon: InkWell(
            onTap: () {
              setState(() {
                widget.obscureText = !widget.obscureText!;
              });
            },
            child: widget.obscureText != null && widget.obscureText == true
                ? SvgPicture.asset(
                    'assets/icon/eye-slash.svg',
                    color: myColors.greyIconColor,
                  )
                : SvgPicture.asset(
                    'assets/icon/eye.svg',
                    color: myColors.greyIconColor,
                  )),
        myColors: myColors,
        hintText: S.of(context).enter_password,
      ),
    );
  }
}

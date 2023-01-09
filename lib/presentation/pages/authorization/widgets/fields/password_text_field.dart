// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_validation/super_validation_string.dart';
import 'package:super_validation/text_form_field_with_icon.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/fields/custom_input_decoration.dart';
import '../../../../widgets/fields/error_icon_widget.dart';
import '../../login_bloc/login_bloc.dart';

class PasswordTextField extends StatefulWidget {
  //final TextEditingController? controller;
  final SuperValidation passwordValidation;
  final String? hintText;
  final TextInputType? textType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  bool? obscureText;
  final Function(String)? onChanged;
  PasswordTextField({
    Key? key,
    //this.controller,
    required this.passwordValidation,
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
    final bloc = context.read<LoginBloc>();
    final myColors = MyTheme.of(context);
    return TextFieldSuperValidationWithIcon(
      altValidation: bloc.passwordValid,
      autovalidateMode: AutovalidateMode.always,
      errorIcon: const ErrorIconWidget(),
      onChanged: widget.onChanged,
      obscureText: widget.obscureText ?? false,
      superValidation: widget.passwordValidation,
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

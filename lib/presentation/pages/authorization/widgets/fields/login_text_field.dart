import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/config/theme/elements/theme_data.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:super_validation/super_validation_a.dart';
import 'package:super_validation/super_validation_string.dart';
import 'package:super_validation/text_form_field_with_icon.dart';
import '../../../../widgets/fields/custom_input_decoration.dart';
import '../../../../widgets/fields/error_icon_widget.dart';
import '../../login_bloc/login_bloc.dart';

class LoginTextField extends StatelessWidget {
  final SuperValidation loginValidation;
  final String? hintText;
  final SuperValidationA altValidation;
  final TextInputType? textType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final Function(String)? onChanged;
  const LoginTextField({
    Key? key,
    required this.loginValidation,
    required this.altValidation,
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
    return TextFieldSuperValidationWithIcon(
      altValidation: altValidation,
      autovalidateMode: AutovalidateMode.always,
      errorIcon: const ErrorIconWidget(),
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      superValidation: loginValidation,
      keyboardType: textType,
      decoration: CustomInputDecoration(
        hintText: S.of(context).enter_login,
        myColors: myColors,
      ),
    );
  }
}

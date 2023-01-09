// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/fields/custom_input_decoration.dart';
import '../../../../widgets/fields/error_icon_widget.dart';

class RestorePasswordReEnterField extends StatefulWidget {
  final SuperValidation passwordValidation;
  final SuperValidationA altValidation;
  final String? hintText;
  final TextInputType? textType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  bool? obscureText;
  final Function(String)? onChanged;
  RestorePasswordReEnterField({
    Key? key,
    //this.controller,
    required this.passwordValidation,
    required this.altValidation,
    this.hintText,
    this.textType,
    this.suffixIcon,
    this.validator,
    this.obscureText,
    this.onChanged,
  }) : super(key: key);

  @override
  State<RestorePasswordReEnterField> createState() =>
      _RestorePasswordReEnterFieldState();
}

class _RestorePasswordReEnterFieldState
    extends State<RestorePasswordReEnterField> {
  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return TextFieldSuperValidationWithIcon(
      errorIcon: const ErrorIconWidget(),
      autovalidateMode: AutovalidateMode.always,
      altValidation: widget.altValidation,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText ?? false,
      superValidation: widget.passwordValidation,
      keyboardType: widget.textType,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
      ],
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
        hintText: S.of(context).repeat_password,
      ),
    );
  }
}

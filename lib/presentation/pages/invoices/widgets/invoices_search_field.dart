import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/config/app_routes.dart';
import 'package:mkk/config/theme/elements/theme_data.dart';
import 'package:mkk/generated/l10n.dart';
import '../../../widgets/fields/custom_input_decoration.dart';

class InvoicesSearchField extends StatelessWidget {
  //final SuperValidation searchValidation;
  final String? hintText;
  final TextInputType? textType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final Function(String)? onChanged;
  const InvoicesSearchField({
    Key? key,
    //required this.searchValidation,
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
    return TextField(
        //errorIcon: const ErrorIconWidget(),
        onChanged: onChanged,
        readOnly: true,
        obscureText: obscureText ?? false,
        //superValidation: searchValidation,
        keyboardType: textType,
        decoration: CustomInputDecoration(
          needOtherFocusColor: true,
          hintText: S.of(context).search,
          myColors: myColors,
          prefixIcon: SvgPicture.asset(
            'assets/icon/search-normal.svg',
            color: myColors.greyIconColor,
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.search);
        });
  }
}

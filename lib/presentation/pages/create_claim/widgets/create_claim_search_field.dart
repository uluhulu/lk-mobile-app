import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/fields/custom_input_decoration.dart';

class CreateClaimSearchField extends StatelessWidget {
  final SuperValidation searchValidation;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextInputType? textType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final EdgeInsets? contentPadding;
  final EdgeInsets? scrollPadding;
  final Function(String)? onChanged;
  const CreateClaimSearchField({
    Key? key,
    required this.searchValidation,
    this.hintText,
    this.textType,
    this.suffixIcon,
    this.validator,
    this.obscureText,
    this.onChanged,
    this.contentPadding,
    this.scrollPadding,
    this.hintStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    final width = MediaQuery.of(context).size.width;
    return TextFieldSuperValidation(
      //errorIcon: const ErrorIconWidget(),
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      superValidation: searchValidation,
      keyboardType: textType,
      scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
      decoration: CustomInputDecoration(
        contentPadding: contentPadding,
        needErrorBorder: false,
        hintText: hintText ?? S.of(context).search_by_name,
        hintStyle: width < 330 ? const TextStyle(fontSize: 13) : hintStyle,
        myColors: myColors,
        suffixIcon: suffixIcon,
        prefixIcon: SvgPicture.asset(
          'assets/icon/search-normal.svg',
          color: myColors.greyIconColor,
        ),
      ),
    );
  }
}

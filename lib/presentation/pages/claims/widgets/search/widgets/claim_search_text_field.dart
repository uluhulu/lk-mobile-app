import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../domain/enums/claims/claims_search_type.dart';
import '../../../../../../domain/enums/invoices/invoices_search_type.dart';
import '../../../../../widgets/fields/custom_input_decoration.dart';
import '../../../claims_search_bloc/claims_search_bloc.dart';

class ClaimSearchTextField extends StatelessWidget {
  final SuperValidation searchValidation;
  final String? hintText;
  final TextInputType? textType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final Function(String)? onChanged;
  const ClaimSearchTextField({
    Key? key,
    required this.searchValidation,
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
    final bloc = context.read<ClaimsSearchBloc>();
    return SuperValidationEnumBuilder<ClaimsSearchType>(
        superValidation: bloc.type,
        builder: (context, value) {
          return TextFieldSuperValidation(
            //errorIcon: const ErrorIconWidget(),
            onChanged: onChanged,
            obscureText: obscureText ?? false,
            superValidation: searchValidation,
            keyboardType: textType,
            decoration: CustomInputDecoration(
              needErrorBorder: false,
              hintText: ClaimsSearchTypeParser.searchByToString(
                  value ?? ClaimsSearchType.number),
              myColors: myColors,
              prefixIcon: SvgPicture.asset(
                'assets/icon/search-normal.svg',
                color: myColors.greyIconColor,
              ),
            ),
          );
        });
  }
}

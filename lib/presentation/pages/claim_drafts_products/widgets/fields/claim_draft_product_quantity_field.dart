import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:super_validation/text_form_field_with_icon.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../widgets/fields/custom_input_decoration.dart';
import '../../../../widgets/fields/error_icon_widget.dart';
import '../../claim_draft_product_bloc/claim_draft_product_cubit.dart';

class ClaimDraftProductQuantityField extends StatelessWidget {
  const ClaimDraftProductQuantityField({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final ClaimDraftProductBloc bloc;

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return TextFieldSuperValidationWithIcon(
      errorIcon: const ErrorIconWidget(),
      superValidation: bloc.quantityClaim,
      keyboardType: TextInputType.number,
      onlyValidationOnTextChange: true,
      autovalidateMode: AutovalidateMode.always,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: CustomInputDecoration(myColors: myColors, hintText: '0'),
    );
  }
}

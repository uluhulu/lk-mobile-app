import 'package:flutter/material.dart';
import 'package:super_validation/text_form_field.dart';
import 'package:super_validation/text_form_field_with_icon.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/fields/custom_input_decoration.dart';
import '../../../../widgets/fields/error_icon_widget.dart';
import '../../claim_draft_product_bloc/claim_draft_product_cubit.dart';

class ClaimDraftProductCommentField extends StatelessWidget {
  const ClaimDraftProductCommentField({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final ClaimDraftProductBloc bloc;

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return TextFieldSuperValidationWithIcon(
      superValidation: bloc.comment,
      errorIcon: const ErrorIconWidget(),
      autovalidateMode: AutovalidateMode.always,
      decoration: CustomInputDecoration(
        myColors: myColors,
        hintText: S.of(context).briefly_describe_the_situation,
      ),
      counterBuilder: (context, currentLength, maxLength) {
        return Text(
          '$currentLength/$maxLength',
          style: TextStyle(
            fontSize: 12,
            color: myColors.greyIconColor,
          ),
        );
      },
      maxLines: 10,
      minLines: 2,
      maxLength: 200,
      scrollPadding: const EdgeInsets.only(bottom: kBasePadding * 5),
    );
  }
}

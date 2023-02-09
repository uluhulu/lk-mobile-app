import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_drafts_bloc/claim_drafts_info_bloc.dart';
import 'package:super_validation/text_form_field.dart';
import 'package:super_validation/text_form_field_with_icon.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/fields/custom_input_decoration.dart';

class ClaimDraftInfoMessageCard extends StatelessWidget {
  const ClaimDraftInfoMessageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimDraftsInfoBloc>();
    final myColors = MyTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).comment,
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: myColors.whiteColor,
                )),
        const SizedBox(height: kPadding),
        TextFieldSuperValidationWithIcon(
          superValidation: bloc.message,
          maxLines: 10,
          minLines: 1,
          maxLength: 200,
          scrollPadding: const EdgeInsets.only(bottom: kBasePadding * 3),
          cursorColor: Colors.white,
          style: TextStyle(color: myColors.whiteColor),
          decoration: MessageInputDecoration(
            needOtherFocusColor: true,
            hintText: S.of(context).enter_claim_comment,
            myColors: MyTheme.of(context),
          ),
        ),
      ],
    );
  }
}

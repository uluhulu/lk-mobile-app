import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/claims/claims_bloc/claims_bloc.dart';
import 'package:super_validation/super_validation.dart';
import '../../../../../../config/theme/elements/theme_data.dart';
import '../../../../../../core/utils/constants.dart';
import '../../../../widgets/fields/custom_input_decoration.dart';
import '../../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../claims_status_list.dart';

class ClaimStatusField extends StatelessWidget {
  final ClaimsBloc bloc;
  const ClaimStatusField({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).claim_status,
            style: Theme.of(context).textTheme.headline4),
        const SizedBox(height: kPadding),
        SuperValidationEnumBuilder<String>(
            superValidation: bloc.claimStatus,
            builder: (context, value) {
              return SuperValidationTextFieldListener(
                superValidation: bloc.claimStatus,
                transformer: (value) => value ?? '',
                readOnly: true,
                maxLines: 3,
                minLines: 1,
                decoration: CustomInputDecoration(
                  needOtherFocusColor: true,
                  hintText: S.of(context).not_selected,
                  myColors: MyTheme.of(context),
                  suffixIcon: SvgPicture.asset(
                    'assets/icon/arrow-right.svg',
                    color: MyTheme.of(context).greyIconColor,
                  ),
                ),
                onTap: () {
                  _onPressed(context);
                },
              );
            }),
      ],
    );
  }

  void _onPressed(BuildContext context) {
    BaseBottomSheetWidget(
      context: context,
      child: BlocProvider.value(
        value: bloc,
        child: const ClaimsStatusList(),
      ),
    ).show();
  }
}

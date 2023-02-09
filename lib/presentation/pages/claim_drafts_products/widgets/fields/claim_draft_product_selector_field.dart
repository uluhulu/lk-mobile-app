import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/fields/custom_input_decoration.dart';
import '../../../../widgets/fields/error_icon_widget.dart';
import '../../../../widgets/modal/base_bottom_sheet_widget.dart';
import '../../claim_draft_product_bloc/claim_draft_product_cubit.dart';
import '../../views/claim_type_list.dart';

class ClaimDraftProductSelectorField extends StatelessWidget {
  const ClaimDraftProductSelectorField({
    Key? key,
    required this.bloc,
    required this.data,
  }) : super(key: key);

  final ClaimDraftProductBloc bloc;
  final ClaimDraftsProductsData data;

  @override
  Widget build(BuildContext context) {
    final claimTypeLength = data.possibleClaimTypes?.length ?? 0;

    return SuperValidationEnumBuilder<String?>(
        superValidation: bloc.claimType,
        builder: (context, value) {
          return claimTypeLength <= 1
              ? TextField(
                  decoration: _overdueDecoration(context),
                  readOnly: true,
                  enabled: true,
                )
              : SuperValidationTextFieldListenerWithIcon(
                  errorIcon: const ErrorIconWidget(),
                  superValidation: bloc.claimType,
                  transformer: (value) {
                    return value ?? '';
                  },
                  altValidation: bloc.claimType,
                  maxLines: 5,
                  minLines: 1,
                  readOnly: true,
                  autovalidateMode: AutovalidateMode.always,
                  onTap: () {
                    BaseBottomSheetWidget(
                      context: context,
                      child: BlocProvider.value(
                        value: bloc,
                        child: ClaimTypeList(
                          claimTypeData: data.possibleClaimTypes ?? {},
                        ),
                      ),
                    ).show();
                  },
                  decoration: _claimTypeSelectorDecoration(context),
                );
        });
  }

  CustomInputDecoration _claimTypeSelectorDecoration(BuildContext context) {
    return CustomInputDecoration(
      needOtherFocusColor: true,
      hintText: S.of(context).not_selected,
      myColors: MyTheme.of(context),
      suffixIcon: SvgPicture.asset(
        'assets/icon/arrow-right.svg',
        color: MyTheme.of(context).greyIconColor,
      ),
    );
  }

  CustomInputDecoration _overdueDecoration(BuildContext context) {
    return CustomInputDecoration(
      filled: true,
      needOtherFocusColor: true,
      otherEnabledColor: true,
      hintText: 'Излишки',
      hintStyle: Theme.of(context)
          .textTheme
          .subtitle1
          ?.copyWith(color: Colors.grey.shade700),
      myColors: MyTheme.of(context),
      suffixIcon: SvgPicture.asset(
        'assets/icon/arrow-right.svg',
        color: MyTheme.of(context).hintColor.withOpacity(0.5),
      ),
    );
  }
}

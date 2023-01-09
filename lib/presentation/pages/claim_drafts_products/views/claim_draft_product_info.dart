import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/claim_drafts_products/claim_drafts_products_bloc/claim_drafts_products_bloc.dart';
import 'package:mkk/presentation/pages/claim_drafts_products/views/claim_type_list.dart';
import 'package:mkk/presentation/pages/claim_drafts_products/widgets/claim_drafts_product_nav_bar.dart';
import 'package:mkk/presentation/widgets/fields/custom_input_decoration.dart';
import 'package:mkk/presentation/widgets/modal/base_bottom_sheet_widget.dart';
import 'package:mkk/presentation/widgets/ui/helpers/widget_or_null_column_helper.dart';
import 'package:mkk/presentation/widgets/ui/helpers/widget_or_null_row_helper.dart';
import 'package:super_validation/super_validation.dart';
import 'package:super_validation/text_form_field.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../widgets/scaffold/screen_view.dart';

class ClaimDraftProductInfo extends StatefulWidget {
  final ClaimDraftsProductsData data;

  const ClaimDraftProductInfo({
    super.key,
    required this.data,
  });

  @override
  State<ClaimDraftProductInfo> createState() => _ClaimDraftProductInfoState();
}

class _ClaimDraftProductInfoState extends State<ClaimDraftProductInfo> {
  late ClaimDraftsProductsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<ClaimDraftsProductsBloc>();
    init(bloc);
  }

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);

    return ScreenView(
        context: context,
        needPadding: false,
        title: 'Черновик претензии',
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(kBasePadding),
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kPadding),
                  Text(
                    widget.data.productName,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: kPadding),
                  WidgetOrNullRowHelper(
                    title: '${S.of(context).series}: ',
                    value: widget.data.seriesName,
                  ),
                  const SizedBox(height: kPadding * 3),
                  WidgetOrNullColumnHelper(
                    needPadding: false,
                    title: 'Кол-во в накладной',
                    value: widget.data.invoiceQuantity.toString(),
                  ),
                  const SizedBox(height: kPadding * 3),
                  Text(
                    'Кол-во в претензии',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: kPadding),
                  TextFieldSuperValidation(
                    superValidation: bloc.quantityClaim,
                    decoration:
                        CustomInputDecoration(myColors: myColors, hintText: ''),
                  ),
                  const SizedBox(height: kPadding * 3),
                  Text(
                    'Тип претензии',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: kPadding),
                  SuperValidationEnumBuilder<String?>(
                      superValidation: bloc.claimType,
                      builder: (context, value) {
                        return SuperValidationTextFieldListener(
                          superValidation: bloc.claimType,
                          transformer: (value) => value ?? '',
                          maxLines: 5,
                          minLines: 1,
                          readOnly: true,
                          onTap: () {
                            BaseBottomSheetWidget(
                              context: context,
                              child: BlocProvider.value(
                                value: bloc,
                                child: ClaimTypeList(
                                  claimTypeData:
                                      widget.data.possibleClaimTypes ?? {},
                                ),
                              ),
                            ).show();
                          },
                          decoration: CustomInputDecoration(
                            needOtherFocusColor: true,
                            hintText: S.of(context).not_selected,
                            myColors: MyTheme.of(context),
                            suffixIcon: SvgPicture.asset(
                              'assets/icon/arrow-right.svg',
                              color: MyTheme.of(context).greyIconColor,
                            ),
                          ),
                        );
                      }),
                  const SizedBox(height: kPadding * 3),
                  Text(
                    'Комментарий',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: kPadding),
                  TextFieldSuperValidation(
                    superValidation: bloc.comment,
                    decoration: CustomInputDecoration(
                        myColors: myColors,
                        hintText: 'Кратко опишите ситуацию'),
                    maxLines: 10,
                    minLines: 2,
                    maxLength: 200,
                    scrollPadding:
                        const EdgeInsets.only(bottom: kBasePadding * 5),
                  ),
                ],
              ),
            ),
            ClaimDraftProductNavBar(id: widget.data.id),
          ],
        ));
  }

  void init(ClaimDraftsProductsBloc bloc) {
    bloc.quantityClaim.text = widget.data.claimQuantity.toString();
    bloc.comment.text = widget.data.claimComment ?? '';
    if (widget.data.claimType != null) {
      bloc.claimType.value = widget.data.possibleClaimTypes!.entries
          .firstWhere(
              (element) => int.parse(element.key) == widget.data.claimType)
          .value;
    }
  }
}

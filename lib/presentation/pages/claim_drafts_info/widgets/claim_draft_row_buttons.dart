import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/config/app_routes.dart';
import 'package:mkk/core/help/navigation_claims_filter_page_params.dart';
import 'package:mkk/presentation/pages/claim_drafts_info/claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../generated/l10n.dart';
import '../../invoices_detail/widgets/invoices_detail_button.dart';

class ClaimDraftRowButtons extends StatelessWidget {
  final int draftId;
  final ClaimDraftsProductsEntity data;
  const ClaimDraftRowButtons({
    super.key,
    required this.data,
    required this.draftId,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ClaimDraftAddProductBloc>();
    final myColors = MyTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(kBasePadding),
      color: myColors.greyContainerColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DetailButton(
            iconPath: 'assets/icon/clipboard-text.svg',
            title: 'Выбрать товар',
            iconColor: myColors.deepBlueCardColor,
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.claimAddItem,
                arguments: ClaimsDraftsAddItemParams(id: draftId, bloc: bloc),
              );
              bloc.add(ClaimDraftAddProductStartE());
            },
          ),
          DetailButton(
            iconPath: 'assets/icon/box-add.svg',
            title: S.of(context).add_excess,
            iconColor: Colors.yellow.shade700,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

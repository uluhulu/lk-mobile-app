import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkk/config/theme/elements/theme_data.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/pages/create_claim/widgets/create_claim_search_field.dart';
import 'package:super_validation/super_validation.dart';

import '../../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../widgets/buttons/primary_elevated_button.dart';
import '../../../../widgets/scaffold/screen_view.dart';
import '../../claim_draft_add_product_bloc/claim_draft_add_product_bloc.dart';
import '../../widgets/add_product/add_product_item_list.dart';

class AddProductStartPage extends StatelessWidget {
  final ClaimDraftsProductsEntity entity;
  const AddProductStartPage({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    final bloc = context.read<ClaimDraftAddProductBloc>();
    return ScreenView(
      context: context,
      title: S.of(context).claim_drafts,
      floatingActionButton: navBarButton(bloc),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Выберите товар из накладной',
            style:
                Theme.of(context).textTheme.headline2?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: kPadding),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icon/info-circle.svg',
                width: 24,
                height: 24,
                color: myColors.blueColor,
              ),
              const SizedBox(width: kPadding / 2),
              Text(
                'За один раз можно добавить 1 товар ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: myColors.blueColor),
              ),
            ],
          ),
          const SizedBox(height: kPadding * 3),
          CreateClaimSearchField(
            searchValidation: bloc.search,
          ),
          const SizedBox(height: kPadding * 3),
          const AddProductItemList(),
        ],
      ),
    );
  }

  Widget navBarButton(ClaimDraftAddProductBloc bloc) {
    return SuperValidationBuilder(
        superValidation: bloc.claimItem,
        builder: (context, validation, isValid) {
          return PrimaryElevatedButton(
            canPress:
                context.read<ClaimDraftAddProductBloc>().claimItem.isValid,
            btnWidth: 200,
            onPressed: () {
              context
                  .read<ClaimDraftAddProductBloc>()
                  .add(ClaimDraftAddProductE());
            },
            text: S.of(context).apply,
          );
        });
  }
}

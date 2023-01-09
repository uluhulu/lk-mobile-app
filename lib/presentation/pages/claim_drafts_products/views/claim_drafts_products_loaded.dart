import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/config/app_routes.dart';
import 'package:mkk/core/help/navigation_claims_filter_page_params.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../claim_drafts_products_bloc/claim_drafts_products_bloc.dart';
import '../widgets/claim_drafts_product_item.dart';

class ClaimDraftsProductsLoaded extends StatelessWidget {
  final ClaimDraftsProductsEntity products;
  const ClaimDraftsProductsLoaded({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          const SizedBox(height: kBasePadding),
      padding: const EdgeInsets.all(kBasePadding),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.data.length,
      itemBuilder: (context, index) {
        return ClaimDraftsProductItem(
            claim: products.data[index],
            onPressed: () {
              _onPressed(context, products.data[index]);
            });
      },
    );
  }

  void _onPressed(BuildContext context, ClaimDraftsProductsData data) {
    final bloc = context.read<ClaimDraftsProductsBloc>();
    Navigator.of(context).pushNamed(
      AppRoutes.claimDraftProductInfo,
      arguments: ClaimsDraftsProductInfoParams(bloc: bloc, data: data),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/claims/products/entity/claims_detail_products_entity.dart';
import '../widgets/card/claim_detail_item_card.dart';

class ClaimProductListLoaded extends StatelessWidget {
  final ClaimsDetailProductsEntity productsData;
  const ClaimProductListLoaded({
    Key? key,
    required this.productsData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: _separatorBuilder,
      padding: const EdgeInsets.only(
          left: kBasePadding, right: kBasePadding, bottom: kBasePadding),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productsData.data.length,
      itemBuilder: _itemBuilder,
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) =>
      const SizedBox(height: kBasePadding);

  Widget _itemBuilder(BuildContext context, int index) {
    final product = productsData.data[index];
    return ClaimDetailItemCard(
      data: product,
    );
  }
}

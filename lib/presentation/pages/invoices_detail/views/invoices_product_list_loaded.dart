import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../../data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';
import '../widgets/invoices_detail_item_card.dart';

class InvoicesProductListLoaded extends StatelessWidget {
  final InvoicesDetailProductsEntity productsData;
  const InvoicesProductListLoaded({
    Key? key,
    required this.productsData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: _separatorBuilder,
      padding: const EdgeInsets.symmetric(horizontal: kBasePadding),
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
    return InvoicesDetailItemCard(
      data: product,
    );
  }
}

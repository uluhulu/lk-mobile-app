import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mkk/presentation/pages/invoices_detail/widgets/invoices_detail_products_pagination.dart';

import '../../../../core/utils/constants.dart';
import '../../../../data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';
import '../invoices_products_bloc/invoices_products_bloc.dart';
import '../widgets/invoices_detail_item_card.dart';

class InvoicesProductListLoaded extends StatelessWidget {
  final InvoicesDetailProductsEntity productsData;
  final int numberPages;
  final Function(int index) onPageChange;
  final String uuid;
  const InvoicesProductListLoaded({
    Key? key,
    required this.productsData,
    required this.numberPages,
    required this.onPageChange,
    required this.uuid,
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
    final bloc = context.read<InvoicesProductsBloc>();
    if (index == productsData.data.length - 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InvoicesDetailItemCard(data: product),
          const SizedBox(height: kBasePadding),
          InvoicesDetailProductsPagination(bloc: bloc, uuid: uuid),
          const SizedBox(height: kBasePadding),
        ],
      );
    }
    return InvoicesDetailItemCard(data: product);
  }
}

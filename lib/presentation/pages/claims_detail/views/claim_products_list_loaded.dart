import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/claims/products/entity/claims_detail_products_entity.dart';
import '../../../../domain/repositories/repository.dart';
import '../../../../locator/locator.dart';
import '../../../widgets/image_picker/claims_files_cubit/claims_files_cubit.dart';
import '../../../widgets/loading_widget.dart';
import '../widgets/card/claim_detail_item_card.dart';

class ClaimProductListLoaded extends StatelessWidget {
  final ClaimsDetailProductsEntity productsData;
  final String status;

  ClaimProductListLoaded({
    Key? key,
    required this.productsData,
    required this.status,
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
    // context.read<ClaimDetailBloc>().add();
    return ClaimDetailItemCard(
    data: product,
    status: status,
    );
  }
}

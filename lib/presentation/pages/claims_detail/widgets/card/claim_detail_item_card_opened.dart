import 'package:flutter/material.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/widgets/ui/helpers/widget_or_null_column_helper.dart';
import '../../../../../data/api/claims/products/entity/claims_detail_products_entity.dart';

class ClaimDetailItemCardOpened extends StatelessWidget {
  final ClaimsProductsData data;
  const ClaimDetailItemCardOpened({
    Key? key,
    required this.data,
  }) : super(key: key);

//TODO: intl

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetOrNullColumnHelper(
            needPadding: false, title: 'Код', value: data.code),
        WidgetOrNullColumnHelper(
            title: S.of(context).invoice_quantity,
            value: data.quantity.toString()),
        WidgetOrNullColumnHelper(
            title: S.of(context).claim_quantity,
            value: data.claimQuantity.toString()),
        WidgetOrNullColumnHelper(
            title: S.of(context).claim_type, value: data.claimTypeName),
        WidgetOrNullColumnHelper(
          title: S.of(context).comment,
          value: data.comment,
        ),
        //TODO: FileWidget
        const SizedBox(height: kBasePadding),
      ],
    );
  }
}

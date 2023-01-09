// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/core/utils/formatter.dart';
import 'package:mkk/generated/l10n.dart';
import 'package:mkk/presentation/widgets/ui/helpers/widget_or_null_column_helper.dart';

import '../../../../data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';

class InvoicesDetailItemOpenedCard extends StatelessWidget {
  final InvoicesDetailProductData data;
  const InvoicesDetailItemOpenedCard({
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
            needPadding: false,
            title: S.of(context).manufacturer,
            value: data.manufacturer),
        WidgetOrNullColumnHelper(
            title: S.of(context).series, value: data.series?.name),
        WidgetOrNullColumnHelper(
            title: S.of(context).packaging, value: data.pack.toString()),
        WidgetOrNullColumnHelper(
            title: S.of(context).quantity, value: data.quantity.toString()),
        WidgetOrNullColumnHelper(
          title: S.of(context).price,
          value: Formatter.asCurrencyNum(data.price),
        ),
        Row(
          children: [
            WidgetOrNullColumnHelper(
                title: S.of(context).vat, value: '${data.nds}%'),
            const SizedBox(width: kBasePadding * 2),
            WidgetOrNullColumnHelper(
                title: S.of(context).vat_sum,
                value: Formatter.asCurrencyNum(data.sumNds)),
          ],
        ),
        WidgetOrNullColumnHelper(
            title: S.of(context).sum, value: Formatter.asCurrencyNum(data.sum)),
      ],
    );
  }
}

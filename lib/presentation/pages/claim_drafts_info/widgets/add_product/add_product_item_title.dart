import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../data/api/claim_drafts/products/entity/claim_drafts_products_entity.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/text/text_with_copy.dart';
import '../../../../widgets/ui/helpers/widget_or_null_column_helper.dart';

class AddProductItemTitle extends StatelessWidget {
  const AddProductItemTitle({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ClaimDraftsProductsData item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithCopy(
          item.productName,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: kPadding / 2),
        Row(
          children: [
            WidgetOrNullColumnHelper(
              needColumnPadding: false,
              needPadding: false,
              title: S.of(context).series,
              value: item.seriesName,
            ),
            const SizedBox(width: kBasePadding),
            WidgetOrNullColumnHelper(
              needColumnPadding: false,
              needPadding: false,
              title: 'Кол-во',
              value: item.invoiceQuantity.toString(),
            ),
          ],
        )
      ],
    );
  }
}

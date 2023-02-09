import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../../data/api/invoices/detail/products/entity/invoices_detail_products_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/text/text_with_copy.dart';
import '../../../widgets/ui/helpers/widget_or_null_column_helper.dart';

class CreateClaimItemTitle extends StatelessWidget {
  const CreateClaimItemTitle({
    Key? key,
    required this.item,
  }) : super(key: key);

  final InvoicesDetailProductData item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWithCopy(
          item.name,
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
              value: item.code,
            ),
            const SizedBox(width: kBasePadding),
            WidgetOrNullColumnHelper(
              needColumnPadding: false,
              needPadding: false,
              title: S.of(context).quantity,
              value: item.quantity.toString(),
            ),
          ],
        )
      ],
    );
  }
}

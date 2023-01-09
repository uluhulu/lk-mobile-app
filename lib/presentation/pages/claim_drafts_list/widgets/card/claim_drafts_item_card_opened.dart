import 'package:flutter/material.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../data/api/claim_drafts/list/entity/claim_dratfs_list_entity.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/text/text_with_copy.dart';
import '../claim_drafts_delete_button.dart';

class ClaimDraftsItemCardOpened extends StatelessWidget {
  final ClaimDraftsListData item;
  const ClaimDraftsItemCardOpened({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(S.of(context).address, style: Theme.of(context).textTheme.subtitle2),
      TextWithCopy(item.cargoAddress,
          style: Theme.of(context).textTheme.subtitle1),
      const SizedBox(height: kBasePadding),
      Text(S.of(context).claim_items,
          style: Theme.of(context).textTheme.subtitle2),
      TextWithCopy('${item.countProductsByClaim}',
          style: Theme.of(context).textTheme.subtitle1),
      const SizedBox(height: kBasePadding),
      Text(S.of(context).invoice_items,
          style: Theme.of(context).textTheme.subtitle2),
      TextWithCopy(item.countProductsByInvoice.toString(),
          style: Theme.of(context).textTheme.subtitle1),
      const SizedBox(height: kPadding),
      const Divider(),
      ClaimDraftsDeleteButton(id: item.id),
      const Divider(),
      const SizedBox(height: kPadding),
    ]);
  }
}

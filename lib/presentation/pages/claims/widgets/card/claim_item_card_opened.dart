import 'package:flutter/material.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/date_format.dart';
import '../../../../../data/api/claims/main/entity/claims_entity.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/text/text_with_copy.dart';

class ClaimItemCardOpened extends StatelessWidget {
  final Data claim;
  const ClaimItemCardOpened({
    Key? key,
    required this.claim,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: kPadding),
      Text(S.of(context).invoice, style: Theme.of(context).textTheme.subtitle2),
      TextWithCopy(
          '${claim.invoice.number} от ${DateFormats.isoDateFormatter(claim.invoice.date)}',
          style: Theme.of(context).textTheme.subtitle1),
      const SizedBox(height: kBasePadding),
      Text(S.of(context).address, style: Theme.of(context).textTheme.subtitle2),
      TextWithCopy(claim.cargo.address,
          style: Theme.of(context).textTheme.subtitle1),
      const SizedBox(height: kBasePadding),
      Text(S.of(context).incoming_doc_number,
          style: Theme.of(context).textTheme.subtitle2),
      TextWithCopy(claim.inNumber,
          style: Theme.of(context).textTheme.subtitle1),
      const SizedBox(height: kPadding),
    ]);
  }
}

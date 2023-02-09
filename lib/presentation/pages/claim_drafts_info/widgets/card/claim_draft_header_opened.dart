import 'package:flutter/material.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/date_format.dart';
import '../../../../../data/api/claim_drafts/info/entity/claim_drafts_info_entity.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/ui/helpers/widget_or_null_column_helper.dart';

class ClaimDraftHeaderOpened extends StatelessWidget {
  final ClaimDraftsInfoData item;
  const ClaimDraftHeaderOpened({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetOrNullColumnHelper(
          isDetail: true,
          title: S.of(context).draft_date,
          value: DateFormats.isoDateFormatter(item.claimDate),
        ),
        WidgetOrNullColumnHelper(
          isDetail: true,
          title: S.of(context).address,
          value: item.cargoAddress,
        ),
        const SizedBox(height: kPadding),
      ],
    );
  }
}

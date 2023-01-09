import 'package:flutter/material.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/invoices/detail/entity/invoices_detail_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/text/text_with_copy.dart';
import '../../../widgets/ui/helpers/invoices_is_marking_helper.dart';
import '../../../widgets/ui/helpers/widget_or_null_column_helper.dart';
import '../../invoices/widgets/card/invoices_marketplace_info.dart';

class InvoicesDetailCardOpened extends StatelessWidget {
  final InvoicesDetail data;
  const InvoicesDetailCardOpened({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(S.of(context).address,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(color: myColors.deepBlueTextColor)),
      const SizedBox(height: kPadding / 2),
      TextWithCopy(data.cargoAddress,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: myColors.whiteColor)),
      const SizedBox(height: kBasePadding * 2),
      InvoicesIsMarkingHelper.isMarkingCard(data.isMarking, context),
      WidgetOrNullColumnHelper(
        isDetail: true,
        title: S.of(context).status_marking,
        value: data.markingStatus?.name,
      ),
      data.marketplaceName.isEmpty
          ? const SizedBox(height: kPadding)
          : const SizedBox(height: kBasePadding * 2),
      InvoicesMarketPlaceInfo(
        isDetail: true,
        marketName: data.marketplaceName,
        marketNumber: data.marketplaceNumber,
        marketStatus: data.marketplaceStatus,
      ),
    ]);
  }
}

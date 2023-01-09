import 'package:flutter/material.dart';
import 'package:mkk/generated/l10n.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/api/invoices/list/entity/invoices_entity.dart';
import '../../../widgets/ui/helpers/invoices_is_marking_helper.dart';
import '../../../widgets/ui/helpers/widget_or_null_column_helper.dart';
import 'card/invoices_marketplace_info.dart';

class InvoicesItemCardOpened extends StatelessWidget {
  final InvoicesData data;
  const InvoicesItemCardOpened({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(S.of(context).address, style: Theme.of(context).textTheme.subtitle2),
      const SizedBox(height: kPadding / 2),
      Text(data.cargoAddress, style: Theme.of(context).textTheme.subtitle1),
      const SizedBox(height: kBasePadding),
      Text(S.of(context).marking, style: Theme.of(context).textTheme.subtitle2),
      const SizedBox(height: kPadding / 2),
      InvoicesIsMarkingHelper.isMarking(data.isMarking, context),
      WidgetOrNullColumnHelper(
        title: S.of(context).status_marking,
        value: data.markingStatus?.name,
      ),
      data.marketplaceName.isEmpty
          ? const SizedBox(height: kPadding)
          : const SizedBox(height: kBasePadding * 2),
      InvoicesMarketPlaceInfo(
        marketName: data.marketplaceName,
        marketNumber: data.marketplaceNumber,
        marketStatus: data.marketplaceStatus,
      ),
    ]);
  }
}

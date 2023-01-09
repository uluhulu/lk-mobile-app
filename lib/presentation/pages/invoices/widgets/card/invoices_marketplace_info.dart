import 'package:flutter/material.dart';
import 'package:mkk/generated/l10n.dart';
import '../../../../widgets/ui/helpers/status_color_helper.dart';
import '../../../../widgets/ui/helpers/widget_or_null_row_helper.dart';

class InvoicesMarketPlaceInfo extends StatelessWidget {
  final bool? isDetail;
  final String marketName;
  final String marketNumber;
  final String marketStatus;
  const InvoicesMarketPlaceInfo({
    Key? key,
    required this.marketName,
    required this.marketNumber,
    required this.marketStatus,
    this.isDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WidgetOrNullRowHelper(
          isDetail: isDetail,
          title: S.of(context).area,
          value: marketName,
        ),
        WidgetOrNullRowHelper(
          isDetail: isDetail,
          title: S.of(context).internet_order,
          value: marketNumber,
        ),
        WidgetOrNullRowHelper(
          //needValueColor: true,
          isDetail: isDetail,
          title: S.of(context).order_status,
          value: marketStatus,
          // valueColor:
          //     StatusColorHelper.getMarketStatusColor(context, marketStatus),
        ),
      ],
    );
  }
}

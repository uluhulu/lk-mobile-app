import 'package:flutter/material.dart';

import '../../../../../config/theme/elements/theme_data.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/date_format.dart';
import '../../../../../generated/l10n.dart';
import '../../../../widgets/text/text_with_copy.dart';

class InvoicesDetailCardDateSum extends StatelessWidget {
  const InvoicesDetailCardDateSum({
    Key? key,
    required this.date,
    required this.price,
  }) : super(key: key);

  final String date;
  final String price;

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return Row(
      children: [
        _date(context, myColors),
        const SizedBox(width: kBasePadding * 2),
        _sum(context, myColors),
      ],
    );
  }

  Widget _sum(BuildContext context, MyThemeData myColors) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(S.of(context).sum,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(color: myColors.deepBlueTextColor)),
      const SizedBox(height: kPadding / 2),
      TextWithCopy(price,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: myColors.whiteColor)),
    ]);
  }

  Widget _date(BuildContext context, MyThemeData myColors) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(S.of(context).date,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(color: myColors.deepBlueTextColor)),
      const SizedBox(height: kPadding / 2),
      TextWithCopy(DateFormats.isoDateFormatter(date),
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: myColors.whiteColor)),
    ]);
  }
}

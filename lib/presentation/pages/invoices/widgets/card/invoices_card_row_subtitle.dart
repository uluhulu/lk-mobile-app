import 'package:flutter/material.dart';
import 'package:mkk/core/utils/formatter.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/date_format.dart';
import '../../../../../generated/l10n.dart';

class InvoicesCardRowSubtitle extends StatelessWidget {
  const InvoicesCardRowSubtitle({
    Key? key,
    required this.date,
    required this.price,
  }) : super(key: key);

  final String date;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SubtitleDate(date: date),
        const SizedBox(width: kBasePadding * 2),
        SubtitleSum(price: price),
      ],
    );
  }
}

class SubtitleSum extends StatelessWidget {
  const SubtitleSum({
    Key? key,
    required this.price,
  }) : super(key: key);

  final String price;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(S.of(context).sum, style: Theme.of(context).textTheme.subtitle2),
      const SizedBox(height: kPadding / 2),
      Text(Formatter.asCurrency(price),
          style: Theme.of(context).textTheme.subtitle1),
    ]);
  }
}

class SubtitleDate extends StatelessWidget {
  const SubtitleDate({
    Key? key,
    required this.date,
  }) : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(S.of(context).date, style: Theme.of(context).textTheme.subtitle2),
      const SizedBox(height: kPadding / 2),
      Text(DateFormats.isoDateFormatter(date),
          style: Theme.of(context).textTheme.subtitle1),
    ]);
  }
}

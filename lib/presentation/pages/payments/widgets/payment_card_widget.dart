import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mkk/config/theme/elements/theme_data.dart';
import 'package:mkk/core/utils/date_format.dart';

import '../../../../core/utils/constants.dart';

class PaymentsCard extends StatelessWidget {
  final String date;
  final String sum;
  const PaymentsCard({
    Key? key,
    required this.date,
    required this.sum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: kBasePadding),
      padding: const EdgeInsets.all(kBasePadding),
      decoration: _decoration(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icon/calendar-2.svg',
            color: myColors.whiteColor,
            height: 27,
            width: 26,
          ),
          const SizedBox(width: kBasePadding),
          PaymentsCardContent(
            myColors: myColors,
            date: date,
            sum: sum,
          )
        ],
      ),
    );
  }

  BoxDecoration _decoration(BuildContext context) {
    return BoxDecoration(
      color: MyTheme.of(context).paymentsCardColor,
      borderRadius: BorderRadius.circular(kBorderRadius),
    );
  }
}

class PaymentsCardContent extends StatelessWidget {
  const PaymentsCardContent({
    Key? key,
    required this.myColors,
    required this.date,
    required this.sum,
  }) : super(key: key);

  final MyThemeData myColors;
  final String date;
  final String sum;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ближайший срок оплаты',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: myColors.whiteColor),
        ),
        Text(
          DateFormats.isoDateFormatter(date),
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: myColors.whiteColor),
        ),
        const SizedBox(height: kPadding),
        Text(
          'Сумма к оплате',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(color: myColors.whiteColor),
        ),
        Text(
          sum,
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: myColors.whiteColor),
        ),
      ],
    );
  }
}

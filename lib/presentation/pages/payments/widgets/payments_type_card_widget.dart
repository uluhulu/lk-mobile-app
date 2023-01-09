import 'package:flutter/material.dart';
import 'package:mkk/presentation/pages/payments/widgets/payments_indexed_icon_widget.dart';

import '../../../../config/theme/elements/theme_data.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/formatter.dart';
import '../../../widgets/text/text_with_copy.dart';

class PaymentsTypeCard extends StatelessWidget {
  final int index;
  final String title;
  final String category;
  final int count;
  final String countLabel;
  final double sum;
  const PaymentsTypeCard({
    Key? key,
    required this.title,
    required this.category,
    required this.count,
    required this.sum,
    required this.countLabel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kBasePadding),
      margin: const EdgeInsets.symmetric(
        horizontal: kBasePadding,
        vertical: kPadding,
      ),
      decoration: _decoration(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IndexedIconWidget(index: index),
          PaymentsTypeContent(
            title: title,
            category: category,
            sum: sum,
            countLabel: countLabel,
            count: count,
          ),
        ],
      ),
    );
  }

  BoxDecoration _decoration(BuildContext context) {
    return BoxDecoration(
      border: Border.all(
        color: MyTheme.of(context).mainDividerColor,
      ),
      borderRadius: BorderRadius.circular(kBorderRadius),
    );
  }
}

class PaymentsTypeContent extends StatelessWidget {
  const PaymentsTypeContent({
    Key? key,
    required this.title,
    required this.category,
    required this.sum,
    required this.countLabel,
    required this.count,
  }) : super(key: key);

  final String title;
  final String category;
  final double sum;
  final String countLabel;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWithCopy(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: kPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(category, style: Theme.of(context).textTheme.subtitle2),
                TextWithCopy(Formatter.asCurrencyNum(sum),
                    style: Theme.of(context).textTheme.bodyText1),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                calculateWidth(context),
                TextWithCopy(count.toString(),
                    style: Theme.of(context).textTheme.bodyText1),
              ]),
            ],
          ),
        ],
      ),
    );
  }

//TODO: вынести логику в отдельный виджет
  Widget calculateWidth(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    if (width < 322) {
      return Text(countLabel, style: Theme.of(context).textTheme.subtitle2);
    }
    if (width > 350 && width < 385) {
      return Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Text(countLabel, style: Theme.of(context).textTheme.subtitle2),
      );
    }
    if (width > 385 && width < 400) {
      return Padding(
        padding: const EdgeInsets.only(right: 30),
        child: Text(countLabel, style: Theme.of(context).textTheme.subtitle2),
      );
    }
    if (width > 400 && width < 420) {
      return Padding(
        padding: const EdgeInsets.only(right: 45),
        child: Text(countLabel, style: Theme.of(context).textTheme.subtitle2),
      );
    }
    return Text(countLabel, style: Theme.of(context).textTheme.subtitle2);
  }
}

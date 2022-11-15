import 'package:flutter/material.dart';
import 'package:mkk/presentation/pages/payments/widgets/payments_indexed_icon_widget.dart';

import '../../../../core/utils/constants.dart';

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
      border: Border.all(color: Theme.of(context).dividerColor),
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
    //TODO: переделать (сделать карточку адаптивной)
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: kPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(category, style: Theme.of(context).textTheme.subtitle2),
                Text('$sum₽', style: Theme.of(context).textTheme.bodyText1),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(countLabel, style: Theme.of(context).textTheme.subtitle2),
                Text(count.toString(),
                    style: Theme.of(context).textTheme.bodyText1),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

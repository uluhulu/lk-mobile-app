import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../../../data/api/receivables/info/entity/receivables_info_entity.dart';
import '../widgets/payment_card_widget.dart';
import '../widgets/payments_overdue_period_widget.dart';
import '../widgets/payments_type_card_widget.dart';

class PaymentsLoadedPage extends StatelessWidget {
  final ReceivablesData data;
  const PaymentsLoadedPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: _padding(),
          child: Text(
            'Задолженность',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        PaymentsCard(
          date: data.dueDate?.date ?? '',
          sum: data.dueDate?.sum.toString() ?? '',
        ),
        OverduePeriodWidget(
            days: data.overduePeriod?.days ?? 0,
            unit: data.overduePeriod?.unit ?? 'Дней'),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.list?.length,
          padding: const EdgeInsets.only(
            bottom: kBasePadding,
          ),
          itemBuilder: (context, index) {
            final item = data.list?.values.elementAt(index);
            return PaymentsTypeCard(
              index: index,
              title: item?.label ?? '',
              category: item?.category ?? '',
              sum: item?.sum ?? 0,
              countLabel: item?.countLabel ?? '',
              count: item?.count ?? 0,
            );
          },
        ),
      ],
    );
  }

  EdgeInsets _padding() {
    return const EdgeInsets.only(
      top: kPadding * 3,
      bottom: kBasePadding,
      left: kBasePadding,
      right: kBasePadding,
    );
  }
}

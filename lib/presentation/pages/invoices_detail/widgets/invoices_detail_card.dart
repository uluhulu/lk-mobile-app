import 'package:flutter/material.dart';
import 'package:mkk/core/utils/constants.dart';
import 'package:mkk/core/utils/formatter.dart';
import 'package:mkk/presentation/pages/invoices_detail/widgets/invoices_detail_card_opened.dart';
import 'package:mkk/presentation/widgets/ui/card/expanded_card_widget.dart';
import '../../../../config/theme/elements/theme_data.dart';
import '../../../../data/api/invoices/detail/entity/invoices_detail_entity.dart';
import '../../../../generated/l10n.dart';
import 'card/invoices_detail_card_date_sum.dart';
import 'card/invoices_detail_card_title.dart';

class InvoicesDetailCard extends StatefulWidget {
  final InvoicesDetailEntity data;

  const InvoicesDetailCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<InvoicesDetailCard> createState() => _InvoicesDetailCardState();
}

class _InvoicesDetailCardState extends State<InvoicesDetailCard> {
  InvoicesDetail get item => widget.data.data.invoice;

  var initiallyExpanded = false;

  @override
  Widget build(BuildContext context) {
    final myColors = MyTheme.of(context);
    final invoiceNumber = item.edo.split('_').first;
    return Container(
      margin: _bodyPadding(),
      decoration: _decoration(myColors),
      child: Padding(
        padding: _contentPadding(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InvoicesDetailCardTitle(
              title: invoiceNumber,
              subtitle: item.customerOrderNumber,
            ),
            const SizedBox(height: kBasePadding),
            InvoicesDetailCardDateSum(
              date: item.date ?? '',
              price: Formatter.asCurrencyNum(item.sum),
            ),
            const SizedBox(height: kBasePadding),
            ExpandedCardWidget(
              arrowIconColor: myColors.whiteColor,
              initiallyExpanded: initiallyExpanded,
              childrenPadding: EdgeInsets.zero,
              tilePadding: EdgeInsets.zero,
              title: Text(S.of(context).details,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: myColors.whiteColor,
                      )),
              children: [
                InvoicesDetailCardOpened(data: item),
              ],
            ),
            const SizedBox(height: kPadding),
          ],
        ),
      ),
    );
  }

  BoxDecoration _decoration(MyThemeData myColors) {
    return BoxDecoration(
      color: myColors.blueDetailCardColor,
      borderRadius: BorderRadius.circular(kBorderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.30),
          spreadRadius: 0,
          blurRadius: 2,
          offset: const Offset(0, 1.3),
        ),
      ],
    );
  }

  EdgeInsets _contentPadding() {
    return const EdgeInsets.symmetric(
      horizontal: kBasePadding,
      vertical: 12,
    );
  }

  EdgeInsets _bodyPadding() {
    return const EdgeInsets.symmetric(
        horizontal: kBasePadding, vertical: kBasePadding);
  }
}
